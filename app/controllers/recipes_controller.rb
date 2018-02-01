class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :recipe_owner_check, only: [:edit, :update, :destroy]
	before_action :logged_in?, only: [:new] 

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		if @recipe.save
			flash[:success] = "Recipe is created successfully!"
			redirect_to user_recipe_path(current_user.id, @recipe.id)
		else
			# flash[:notice] = "Something went wrong, please try again. (Please fill in all the fields)"
			respond_to do |format|
          		format.html { redirect_to new_user_recipe_path(current_user.id) }
          		format.js
        	end
			
		end
	end

	def show
	end

	def edit
	end

	def update
		@recipe.update(recipe_params)
		flash[:success] = "Recipe has been updated successfully!"
		redirect_to user_recipe_path(@recipe.user_id, @recipe.id)
		@recipe.save
	end

	def destroy
		@recipe.destroy
		flash[:success] = "Recipe has been deleted successfully!"
		redirect_to user_path(current_user.id)
	end

	private

	def find_recipe 
		if @recipe = Recipe.find_by(id: params[:id])
			return @recipe
		else
			redirect_to "/", error: "Recipe does not exist!"
		end
	end

	def recipe_owner_check
		if logged_in? and current_user.id != @recipe.user_id
			redirect_to "/", alert: "Only the recipe's owner has the access!"
		elsif !logged_in?
			redirect_to "/", alert: "Only the recipe's owner has the access!"
		end
	end

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, :user_id, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end
end
