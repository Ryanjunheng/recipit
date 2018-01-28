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
			flash[:notice] = "Recipe is created successfully!"
			redirect_to user_recipe_path(current_user.id, @recipe.id)
		else
			p @recipe.errors
			flash[:notice] = "Something went wrong, please try again."
			redirect_to new_user_recipe_path(current_user.id)
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
		flash[:notice] = "Recipe has been deleted successfully!"
		redirect_to user_path(current_user.id)
	end

	private

	def find_recipe 
		@recipe = Recipe.find(params[:id])
	end

	def recipe_owner_check
		redirect_to "/", notice: "Only the recipe's owner has the access!" unless current_user.id == @recipe.user_id
	end

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, :user_id, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end
end
