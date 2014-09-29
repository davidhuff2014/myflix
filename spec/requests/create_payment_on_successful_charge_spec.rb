require 'spec_helper'

describe 'Create payment on successful charge' do
  let(:event_data) do
    {
        "id" => "evt_14hn4ULJUrOSUSj6JuMKNGhS",
        "created" => 1411931462,
        "livemode" => false,
    "type" => "charge.succeeded",
        "data" => {
        "object" => {
        "id" => "ch_14hn4ULJUrOSUSj62rfFNFsz",
        "object" => "charge",
        "created" => 1411931462,
        "livemode" => false,
    "paid" => true,
    "amount" => 999,
        "currency" => "usd",
        "refunded" => false,
    "card" => {
        "id" => "card_14hn4SLJUrOSUSj6E0sX38n6",
        "object" => "card",
        "last4" => "4242",
        "brand" => "Visa",
        "funding" => "credit",
        "exp_month" => 9,
        "exp_year" => 2016,
        "fingerprint" => "w5v5eMmpgfUvy4fe",
        "country" => "US",
        "name" =>  nil,
    "address_line1" =>  nil,
    "address_line2" =>  nil,
    "address_city" =>  nil,
    "address_state" =>  nil,
    "address_zip" =>  nil,
    "address_country" =>  nil,
    "cvc_check" => "pass",
        "address_line1_check" =>  nil,
    "address_zip_check" =>  nil,
    "customer" => "cus_4rW6JKHoMok032"
    },
        "captured" => true,
    "refunds" => {
        "object" => "list",
        "total_count" => 0,
        "has_more" => false,
    "url" => "/v1/charges/ch_14hn4ULJUrOSUSj62rfFNFsz/refunds",
        "data" => []
    },
        "balance_transaction" => "txn_14hn4ULJUrOSUSj6Oif2TZQU",
        "failure_message" =>  nil,
    "failure_code" =>  nil,
    "amount_refunded" => 0,
        "customer" => "cus_4rW6JKHoMok032",
        "invoice" => "in_14hn4ULJUrOSUSj63Kh52N9t",
        "description" =>  nil,
    "dispute" =>  nil,
    "metadata" => {},
        "statement_description" => "Myflix",
        "receipt_email" =>  nil,
    "receipt_number" =>  nil
    }
    },
        "object" => "event",
        "pending_webhooks" => 1,
        "request" => "iar_4rW6mN3z5fvoYq"
    }
  end

  it 'creates a payment with the webhook from stripe for charge succeeded', :vcr do
    post '/stripe_events', event_data
    expect(Payment.count).to eq(1)
  end

  it 'creates the payment associated with the user', :vcr do
    alice = Fabricate(:user, customer_token: 'cus_4rW6JKHoMok032')
    post '/stripe_events', event_data
    expect(Payment.first.user).to eq(alice)
  end

  it 'creates the payment with the amount', :vcr do
    alice = Fabricate(:user, customer_token: 'cus_4rW6JKHoMok032')
    post '/stripe_events', event_data
    expect(Payment.first.amount).to eq(999)
  end

  it 'creates the payment with reference id', :vcr do
    alice = Fabricate(:user, customer_token: 'cus_4rW6JKHoMok032')
    post '/stripe_events', event_data
    expect(Payment.first.reference_id).to eq('ch_14hn4ULJUrOSUSj62rfFNFsz')
  end
end