class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    # using scope in user.rb for ci_find needed to be case insensitive
    # user = User.find_by(email: params[:email])
    user = User.ci_find(:email, params[:email])

    if User.count > 0
      if user && user.authenticate(params[:password])
        if user.active?
          session[:user_id] = user.id
          redirect_to home_path
          flash[:success] = 'You are signed in, enjoy!'
        else
          flash[:danger] = 'Your account has been suspended, please contact customer service.'
          redirect_to sign_in_path
        end
      else
        flash[:danger] = 'Invalid email or password.'
        redirect_to sign_in_path
      end
    else
      flash[:danger] = "You must add at least one user before attempting to log in!"
      redirect_to register_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:success] = 'You are signed out.'
  end
end
