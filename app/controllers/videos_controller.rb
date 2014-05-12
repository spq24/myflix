class VideosController < ApplicationController
 before_filter :require_user 


  def index
    @videos = Video.all
    @category = Category.all
  end

  def show
    @video = VideoDecorator.decorate(Video.find(params[:id]))
    @reviews = @video.reviews
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end

  def destroy
    Video.find(params[:id]).destroy
    flash[:success] = "Video Deleted."
    redirect_to videos_path
  end

end