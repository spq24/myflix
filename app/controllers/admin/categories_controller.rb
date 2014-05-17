class Admin::CategoriesController < AdminsController


	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "You have successfully added the category #{@category.category}."
			redirect_to new_admin_category_path
		else
			flash[:danger] = "Something Went Wrong! Your category wasn't saved properly"
			render :new
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			flash[:success] = "You have successfully edited the category: #{@category.category}."
			redirect_to edit_admin_category_path
		else
			flash[:danger] = "Something Went Wrong! Your category wasn't edited properly"
			render :new
		end	
	end

	def index
		@categories = Category.all
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
