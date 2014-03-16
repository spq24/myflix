class ReviewsController < ApplicationController
	before_filter :require_user

	def create
		@video = Video.find(params[:video_id])
		@review = Review.new(review_params)
		@review[:video_id] = @video.id
    	@review[:user_id] = session[:user_id]
		if @review.save
			flash[:success] = "Your review has been added."
			redirect_to @video
		else
			flash[:danger] = "There was a problem adding your review!"
			@reviews = @video.reviews.reload
			render 'videos/show'
		end
	end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :user_id, :video_id)
  end
end