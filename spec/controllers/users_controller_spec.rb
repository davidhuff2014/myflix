require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets the @user variable' do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
    it 'renders the new template' do
      get :new
      response.should  render_template :new
    end
  end

  describe 'POST create' do
    let(:user) { Fabricate(:user) }
    it { user.should validate_presence_of(:email) }
    it { user.should validate_presence_of(:password_digest) }
    it { user.should validate_presence_of(:full_name) }

    it { user.should validate_uniqueness_of(:email) }

    it { should redirect_to_url }
    it 'renders the new template when the input is invalid'
  end
end