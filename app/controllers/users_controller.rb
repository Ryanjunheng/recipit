class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update]
	before_action :current_user_check, only: [:edit, :update]

	def new 
		@user = User.new
	end

	def create
		user = User.new(user_params)
  		if user.save
    		session[:user_id] = user.id
    		flash[:notice] = "Signed up successfully"
    		redirect_to '/'
  		else
    		redirect_to '/sign_up'
  		end
	end

	def show
	end

	def edit
	end

	def update
		@user.update(user_params)
		flash[:notice] = "Profile has been updated successfully!"
		redirect_to @user
	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
