class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_user
  
  def set_user
    unless session[:uname]
      session[:uname] = request.env['REMOTE_USER']
      #session[:uname] = "wallace4" unless ENV["SERVER_NAME"] == "bruiser.mit.edu"
    end
    @me = Apache.new(session[:uname])
  end
  
end
