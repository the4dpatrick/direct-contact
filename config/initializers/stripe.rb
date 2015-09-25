Stripe.api_key = ENV["STRIPE_API_KEY"]
STRIPE_PUBLIC_KEY = ENV["STRIPE_PUBLIC_KEY"]

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted' do |event|
    user = User.find_by_customer_id(event.data.object.customer)
    user.expire
  end

  events.subscribe 'invoice.payment_succeeded' do |event|
    user = User.find_by_customer_id(event.data.object.customer)
    user.reset_for_new_cycle
  end
end
