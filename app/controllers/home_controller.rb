class HomeController < ApplicationController

	def index
		@recipe = Recipe.includes(:user).order(:created_at).page params[:page]

		resp = RestClient.get("http://api.openweathermap.org/data/2.5/weather?q=kuala%20lumpur&appid=5261318cfb0bef89c5636df1236c3240")
  		hash = JSON.parse(resp.body)
  		@weather = hash["weather"][0]["description"]
  		@city = hash["name"]
  		@icon = hash["weather"][0]["icon"]
  		@temp = (hash["main"]["temp"] - 273.15).round(1) 
	end

	def search
		if params[:search] != ""
           @results = Recipe.where('lower(title) LIKE ?', "%#{params[:search]}%").order(:created_at)
           @user = User.where('lower(name) LIKE ?', "%#{params[:search]}%").order(:created_at)
       end  
    end
end
