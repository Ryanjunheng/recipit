class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def sign_in(user)
    session[:user_id] = user.id
  end
  	
  def current_user_check
    redirect_to "/", notice: "Hold it right there! Please login or signup first to access" unless current_user.id == @user.id
  end

end
