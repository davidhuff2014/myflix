class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: 'David.Huff@computer-critters.com', subject: 'Welcome to Myflix!'
  end
end