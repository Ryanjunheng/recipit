class HomeController < ApplicationController

	def index
		@recipe = Recipe.includes(:user).order(:created_at).page params[:page]
	end

	def search
		if params[:search] != ""
           @results = Recipe.where('lower(title) LIKE ?', "%#{params[:search]}%").order(:created_at)
           @user = User.where('lower(name) LIKE ?', "%#{params[:search]}%").order(:created_at)
       end  
    end
end
