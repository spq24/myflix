class AdminsController < ApplicationController
	before_filter :require_admin
	before_filter :require_user

	
	private

	def require_admin
		if !current_user.admin?
			flash[:danger] = "You are not authorized to do that."
			redirect_to home_path
		end
	end
end