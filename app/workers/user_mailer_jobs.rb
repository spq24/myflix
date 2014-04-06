class UserMailerJobs
	include Sidekiq::Worker

	def perform(invitation_token)
	   invitation = Invitation.find_by token: 'invitation_token'
	   UserMailer.send_invitation_email(invitation).deliver
	end

end