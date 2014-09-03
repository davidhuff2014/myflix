class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first

    if user
      AppMailer.delay.send_forgot_password(user)
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? 'Email cannot be blank.' : 'If your email address is in our system, you will receive an email with instructions.'
      redirect_to forgot_password_path
    end
  end
end
