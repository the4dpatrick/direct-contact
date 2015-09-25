class CreateCustomerWorker
  include Sidekiq::Worker
  attr_accessor :user, :customer

  def perform(user_id, stripe_token, coupon)
    @user = User.find(user_id)
    create_customer(stripe_token, coupon)
    update_user
  end

  def create_customer(stripe_token, coupon)
    stripe_options = { email: @user.email, description: @user.name,
      card: stripe_token, plan: @user.plan.name }
    stripe_options.merge!(coupon: coupon) if coupon.present?
    create_and_set_stripe_customer(stripe_options)
  end

  def create_and_set_stripe_customer(stripe_options)
    begin
      @customer = Stripe::Customer.create(stripe_options)
    rescue Stripe::InvalidRequestError
    end
  end

  def update_user
    @user.update_with_stripe_data(@customer) if @customer
  end
end
