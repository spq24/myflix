class CategoriesController < ApplicationController
	before_filter :require_user
	
	def index
		@categories = Category.all
		@videos = Video.all
	end

	def show
		@category = Category.find(params[:id])
	end

	def destroy
	    Category.find(params[:id]).destroy
	    flash[:success] = "Category Deleted."
	    redirect_to admin_categories_path
  	end

  	private

	def category_params
    	params.require(:category).permit(:category)
  	end
end
