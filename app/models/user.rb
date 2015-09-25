class User < ActiveRecord::Base
  belongs_to :plan

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  attr_accessor :stripe_token, :coupon

  before_save :downcase_attributes, :update_stripe
  before_destroy :cancel_subscription
  after_create :create_stripe_customer

  validates_presence_of   :email
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, on: :create
  validates_confirmation_of :password, on: :create
  validates_length_of       :password, within: Devise.password_length, allow_blank: true

  validates :name, presence: true

  # Contact Search
  def attempt_search
    update_columns(total_search_attempts: total_search_attempts + 1,
                   search_attempts_this_cycle: search_attempts_this_cycle + 1)
  end

  def remaining_found_emails_count
    plan ? plan.monthly_limit - found_emails_count_this_cycle : 0
  end

  def successful_search
    update_columns(total_found_emails_count: total_found_emails_count + 1,
                   found_emails_count_this_cycle: found_emails_count_this_cycle + 1)
  end

  def reset_for_new_cycle
    update_columns(found_emails_count_this_cycle: 0,
                   search_attempts_this_cycle: 0)
  end

  def below_monthly_limit?
    found_emails_count_this_cycle < plan.monthly_limit if plan
  end

  # Stripe Payments
  def update_plan(plan_name)
    return if plan_name == 'admin'
    update_columns(plan_id: Plan.where(name: plan_name).pluck(:id).first)
    if customer_id.present?
      UpdateSubscriptionWorker.perform_async(customer_id: customer_id, plan: plan_name)
    end
  end

  def update_stripe
    if customer_id
      UpdateCustomerWorker.perform_async(id, stripe_token)
    end
  end

  def create_stripe_customer
    # refactor stripe_token error
    raise "Stripe token not present. Can't create account." unless stripe_token.present?
    CreateCustomerWorker.perform_async(id, stripe_token, coupon)
  end

  def cancel_subscription
    update_columns({plan_id: nil})
    CancelSubscriptionWorker.perform_async(customer_id) unless customer_id.nil?
  end

  def expire
    Email.to self.email, :expiration
    cancel_subscription
  end

  def update_with_stripe_data(api_response)
    # update attributes without invoking callbacks
    update_columns(last_4_digits: api_response.cards.data.first["last4"],
                   customer_id: api_response.id)
  end

  private

  def downcase_attributes
    email.downcase
    name.downcase
  end
end
