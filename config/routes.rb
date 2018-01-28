Rails.application.routes.draw do

	root "home#index"
	resources :users do
		resources :recipes 
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	get "/sign_up" => "users#new", as: "sign_up"
  	get "/sign_in" => "sessions#new", as: "sign_in"
  	post "/login" => "sessions#create", as: "login"
  	delete "/sign_out" => "sessions#destroy", as: "sign_out"
  	get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
