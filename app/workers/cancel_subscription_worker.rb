class CancelSubscriptionWorker
  include Sidekiq::Worker

  def perform(customer_id)
    @customer = Stripe::Customer.retrieve(customer_id)
    cancel_subscription_if_various_conditions_apply unless customer_id.nil?
  end

  def cancel_subscription_if_various_conditions_apply
    @customer.cancel_subscription if has_a_subscription?
  end

  def has_a_subscription?
    !(@customer.respond_to? 'deleted') && has_an_active_subscription?
  end

  def has_an_active_subscription?
    sub_id = @customer.subscriptions.data.first.id
    sub_status = @customer.subscriptions.retrieve(sub_id).status
    sub_status == 'active'
  end
end
