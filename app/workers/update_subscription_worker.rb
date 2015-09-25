class UpdateSubscriptionWorker
  include Sidekiq::Worker

  def perform(options)
    @customer = Stripe::Customer.retrieve(options["customer_id"])
    if active_subscription?
      update_subscription_plan(options)
    else
      @customer.subscriptions.create(plan: options["plan"])
    end
  end

  def active_subscription?
    if @customer.subscriptions.data.present? && @customer.subscriptions.data.first
      @sub_id = @customer.subscriptions.data.first.id
    end
  end

  def update_subscription_plan(options)
    subscription = @customer.subscriptions.retrieve(@sub_id)
    subscription.plan = options["plan"]
    subscription.save
  end
end
