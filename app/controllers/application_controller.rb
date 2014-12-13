class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate
  before_filter :check_status
  
  #Stores user associated with a session cookie for use in other pages and controllers
  def authenticate
    @me = CurrentUser.find_by(uname: session[:uname])
    return true
  end
  
  #Stores username from apache in session cookie on successful login atempts
  #NOTE: This page should only be reached if the login atempt was successful.
  def success
    authenticate_or_request_with_http_basic do | username, password |
      session[:redirect] = false
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
  
  def check_status
    if session[:redirect]
      session[:redirect] = false
      return true
    end
    if @me.status == 0 && @me.group?("dkepledge")
      session[:redirect] = true
      flash[:notice] = "<h4>Welcome to the DKE Server.  Please update your information for the website.</h4>".html_safe
      redirect_to "#{main_app.brothers_path}/#{@me.brother.id}/edit"
    end
  end
  
end
