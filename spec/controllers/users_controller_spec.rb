require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'successful user sign up' do

      it 'redirects to the sign in page' do
        result = double(:sign_up_result, successful?: true)
        # add expectation to get rid of negative deprecation warning
        # expect(UserSignup).any_instance.to receive(:sign_up).and_return(result)
        # and again
        expect_any_instance_of(UserSignup).to receive(:sign_up).and_return(result)
        # UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'failed user sign up' do
      it 'renders the new template' do
        customer = double(:customer, successful?: false, error_message: 'Your card was declined.')
        # add expectation to get rid of negative deprecation warning
        expect(StripeWrapper::Customer).to receive(:create).and_return(customer)
        # StripeWrapper::Customer.should_receive(:create).and_return(customer)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123'
        expect(response).to render_template :new
      end

      it 'sets the flash error message' do
        customer = double(:charge, successful?: false, error_message: 'Your card was declined.')
        # add expectation to get rid of negative deprecation warning
        expect(StripeWrapper::Customer).to receive(:create).and_return(customer)
        # StripeWrapper::Customer.should_receive(:create).and_return(customer)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123'
        expect(flash[:danger]).to eq('Your card was declined.')
      end
    end
  end

  describe 'GET show' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :show, id: 3 }
    end

    it 'sets @user' do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe 'GET new_with_invitation_token' do
    it 'renders the :new view template' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it 'sets @user with recipient email' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it 'it sets @invitation_token' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it 'redirects to expired token page for invalid tokens' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: '5235243gdsgfgds'
      expect(response).to redirect_to expired_token_path
    end
  end
end