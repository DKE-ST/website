class StaticPagesController < ApplicationController
  def home
  end
  
  def php_header
  end
  
  def success
    session[:uname] = request.env['REMOTE_USER']
    session[:uname] = "wallace4" unless ENV["SERVER_NAME"] == "bruiser.mit.edu"
    redirect_to root_url
  end
  
  def loggedout
    session[:uname] = nil
    redirect_to root_url
  end
end
