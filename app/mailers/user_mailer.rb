class UserMailer < ActionMailer::Base.delivery_method = :smtp
  default from: "spq2461@gmail.com"

  def send_welcome_email(user)
  	@user = user
  	mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix!"
  end
end
