require 'spec_helper'

describe UserSignup do
  describe '#sign_up' do
    context 'valid personal info and valid card' do

      let(:charge) { double(:charge, successful?: true) }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }
      before { ActionMailer::Base.deliveries.clear }

      it 'creates the user', :vcr do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it 'makes the user follow the inviter' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe' }, invitation_token: invitation.token
        joe =  User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be true
      end

      it 'makes the inviter follow the user' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe' }, invitation_token: invitation.token
        joe =  User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be true
      end

      it 'expires the invitation upon acceptance' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Doe' }, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end

      it 'sends out email containing the user name with valid input' do
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Smith' }
        expect(ActionMailer::Base.deliveries.last.body).to include('Joe Smith')
      end

      it 'sends out the email to the user with valid input' do
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'Joe Smith' }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end
    end

    context 'valid personal info and declined card' do

      it 'does not create a new user record' do
        charge = double(:charge, successful?: false, error_message: 'Your card was declined.')
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123'
        expect(User.count).to eq(0)
      end
    end

    context 'invalid personal info' do

      before { post :create, user: { password: 'password', full_name: 'Jane Doe' } }

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'does not charge the card' do
        StripeWrapper::Charge.should_not_receive(:create)
      end

      before { ActionMailer::Base.deliveries.clear }
      it 'does not send out email with invalid input' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end