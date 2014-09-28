Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end
end
