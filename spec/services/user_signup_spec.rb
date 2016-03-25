require 'spec_helper'

describe UserSignup do
  describe '#sign_up' do

    before { ActionMailer::Base.deliveries.clear }

    context 'valid personal info and valid card' do

      let(:customer) { double(:customer, successful?: true, customer_token: 'abcdefg') }
      # add expectation to get rid of negative deprecation warning
      before { expect(StripeWrapper::Customer).to receive(:create).and_return(customer) }
      # before { StripeWrapper::Customer.should_receive(:create).and_return(customer) }

      it 'creates the user', :vcr do
        UserSignup.new(Fabricate.build(:user)).sign_up('some_stripe_token', nil)
        expect(User.count).to eq(1)
      end

      it 'stores the customer token from stripe' do
        UserSignup.new(Fabricate.build(:user)).sign_up('some_stripe_token', nil)
        expect(User.first.customer_token).to eq('abcdefg')
      end

      it 'makes the user follow the inviter' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up('some_stripe_token', invitation.token)
        joe =  User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be true
      end

      it 'makes the inviter follow the user' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up('some_stripe_token', invitation.token)
        joe =  User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be true
      end

      it 'expires the invitation upon acceptance' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', password: 'password', full_name: 'Joe Doe')).sign_up('some_stripe_token', invitation.token)
        expect(Invitation.first.token).to be_nil
      end

      it 'sends out email containing the user name with valid input' do
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com', full_name: 'Joe Smith')).sign_up('some_stripe_token', nil)
        expect(ActionMailer::Base.deliveries.last.body).to include('Joe Smith')
      end

      it 'sends out the email to the user with valid input' do
        UserSignup.new(Fabricate.build(:user, email: 'joe@example.com')).sign_up('some_stripe_token', nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end
    end

    context 'valid personal info and declined card' do

      it 'does not create a new user record' do
        customer = double(:customer, successful?: false, error_message: 'Your card was declined.')
        # add expectation to get rid of negative deprecation warning
        expect(StripeWrapper::Customer).to receive(:create).and_return(customer)
        # StripeWrapper::Customer.should_receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user)).sign_up('123', nil)
        expect(User.count).to eq(0)
      end
    end

    context 'invalid personal info' do

      it 'does not create the user' do
        UserSignup.new(User.new(email: 'dave@example.com')).sign_up('123', nil)
        expect(User.count).to eq(0)
      end

      it 'does not charge the card' do
        # add expectation to get rid of negative deprecation warning
        # StripeWrapper::Customer.should_not_receive(:create)
        expect(StripeWrapper::Customer).not_to receive(:create)
        UserSignup.new(User.new(email: 'dave@example.com')).sign_up('123', nil)
      end

      it 'does not send out email with invalid input' do
        UserSignup.new(User.new(email: 'dave@example.com')).sign_up('123', nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end