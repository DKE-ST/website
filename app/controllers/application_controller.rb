class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate
  
  def authenticate
    @me = User.find_by(uname: session[:uname])
    return true
  end
  
  def success
    authenticate_or_request_with_http_basic do | username, password |
      puts "-----------------------------------------"
      puts username, password
      puts "-----------------------------------------"
      session[:expires] = Time.now
      session[:uname] = username
      redirect_to root_url
    end
  end
  
  def loggedout
    session[:uname] = nil
    redirect_to root_url
  end
  
end
