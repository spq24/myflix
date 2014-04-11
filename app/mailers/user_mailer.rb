class UserMailer < ActionMailer::Base
  default from: "info@myflix.com"

  def send_welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Welcome to Myflix!")
  end

  def send_forgot_password(user)
  	@user = user
  	mail to: @user.email, subject: "Please reset your password for MyFlix"
  end

  def send_invitation_email(invitation_id)
  	@invitation = invitation
  	mail to: @invitation.recipient_email, subject: "Invitation to join MyFlix"
  end
end
