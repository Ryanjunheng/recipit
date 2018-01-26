class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
    
    	if user && user.authenticate(params[:password])
      
      	session[:user_id] = user.id
      	flash[:notice] = "Signed in sucessfully"
      	redirect_to '/'
    else
    
    	flash[:notice] = "Email and password mismatched. Try again."
    	redirect_to '/sign_in'
    end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Signed out sucessfully."
    	redirect_to '/'
	end

	def create_from_omniauth
     auth_hash = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

     # if: previously already logged in with OAuth
     if authentication != nil
       user = authentication.user
       authentication.update_token(auth_hash)
       @notice = "Signed in sucessfully"
     # else: user logs in with OAuth for the first time
    elsif (user = User.find_by(email: auth_hash['info']['email'])) != nil
        authentication = Authentication.create_with_omniauth(auth_hash)
        authentication.update(user_id: user.id)
       
     else
      authentication = Authentication.create_with_omniauth(auth_hash)
       user = User.create_with_auth_and_hash(authentication, auth_hash)
       # you are expected to have a path that leads to a page for editing user details
       @notice = "Login via Facebook successfully"
     end

     sign_in(user)
     redirect_to "/" , :notice => @notice
   end

end

