class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate
  
  #Stores user associated with a session cookie for use in other pages and controllers
  def authenticate
    @me = User.find_by(uname: session[:uname])
    return true
  end
  
  #Stores username from apache in session cookie on successful login atempts
  #NOTE: This page should only be reached if the login atempt was successful.
  def success
    authenticate_or_request_with_http_basic do | username, password |
      session[:expires] = Time.now
      session[:uname] = username
      redirect_to root_url
    end
  end
  
  #Removes username from session cookie to log out a user
  def loggedout
    session[:uname] = nil
    redirect_to root_url
  end
  
end
