class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate
  before_action :checks
  
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
  
 private
  
    def checks
    if session[:redirect]
      session[:redirect] = false
      return true
    else
      check_status
      check_passwd_age
    end
  end
  
  def check_status
    if @me.status == 0 && @me.group?("dkepledge")
      session[:redirect] = true
      flash[:notice] = "<h4>Welcome to the DKE Server.  Please update your information for the website.</h4>".html_safe
      redirect_to "#{main_app.brothers_path}/#{@me.brother.id}/edit"
    end
  end
  
  def check_passwd_age
    if @me.shadow
      if Date.today - @me.shadow.updated_at.to_date > 365
        session[:redirect] = true
        flash[:notice] = "<h4>It has been over a year since you previously set you password.  Please set a new different password.</h4>".html_safe
        redirect_to main_app.ch_passwd_path
      end
    end
  end
  
end
