class RelationshipsController < ApplicationController
	before_filter :require_user

	def index
		@relationships = current_user.following_relationships
	end

	def destroy
		relationship = Relationship.find(params[:id])
		relationship.destroy if relationship.follower == current_user
		redirect_to people_path
	end

	def create
	    follower = current_user
	    leader = User.find(params[:leader_id])
	    relationship = Relationship.new(follower: follower, leader: leader)
	    relationship.save if current_user.can_follow?(leader)
	    redirect_to people_path
	end
end
