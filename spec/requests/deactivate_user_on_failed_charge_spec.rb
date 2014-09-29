require 'spec_helper'

describe 'Deactivate user on failed charge' do
  let(:event_data) do{
      "id" => "evt_14iAqFLJUrOSUSj6TCNEkUAJ",
      "created" => 1412022835,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
          "object" => {
          "id" => "ch_14iAqFLJUrOSUSj6DCCgwwPV",
      "object" => "charge",
      "created" => 1412022835,
      "livemode" => false,
      "paid" => false,
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "card" => {
          "id" => "card_14iAngLJUrOSUSj694wbE57Q",
      "object" => "card",
      "last4" => "0341",
      "brand" => "Visa",
      "funding" => "credit",
      "exp_month" => 9,
      "exp_year" => 2018,
      "fingerprint" => "3HFeGIluAqd9wOmq",
      "country" => "US",
      "name" => nil,
      "address_line1" => nil,
      "address_line2" => nil,
      "address_city" => nil,
      "address_state" => nil,
      "address_zip" => nil,
      "address_country" => nil,
      "cvc_check" => "pass",
      "address_line1_check" => nil,
      "address_zip_check" => nil,
      "customer" => "cus_4ruZ5fC5Izs1bd"
  },
      "captured" => false,
      "refunds" => {
          "object" => "list",
      "total_count" => 0,
      "has_more" => false,
      "url" => "/v1/charges/ch_14iAqFLJUrOSUSj6DCCgwwPV/refunds",
      "data" => []
  },
      "balance_transaction" => nil,
      "failure_message" => "Your card was declined.",
      "failure_code" => "card_declined",
      "amount_refunded" => 0,
      "customer" => "cus_4ruZ5fC5Izs1bd",
      "invoice" => nil,
      "description" => "payment to fail",
      "dispute" => nil,
      "metadata" => {},
      "statement_description" => "payment to fail",
      "receipt_email" => nil,
      "receipt_number" => nil
  }
  },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4rufGdlzJmosGi"
  }
  end
  it 'deactivates a user with the web hook data from stripe for a charge failed', :vcr do
    alice = Fabricate(:user, customer_token: 'cus_4ruZ5fC5Izs1bd')
    post '/stripe_events', event_data
    expect(alice).not_to be_active
    # TODO HW8-3 8:08
  end
end