class UserMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def send_welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Welcome to Myflix!")
  end
end
