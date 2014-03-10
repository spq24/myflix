class CategoriesController < ApplicationController
	def index
		@categories = Category.all
		@videos = Video.all
	end

	def show
		@category = Category.find(params[:id])
		@videos = @category.videos
	end
end
