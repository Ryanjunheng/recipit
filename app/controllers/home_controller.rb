class HomeController < ApplicationController

	def index
		@recipe = Recipe.includes(:user).order(:created_at).page params[:page]
	end
end
