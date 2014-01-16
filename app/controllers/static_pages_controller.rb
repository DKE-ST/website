class StaticPagesController < ApplicationController
  def home
  end
  
  def php_header
  end
  
  def settings
    if @me.in_group("brockicken")
      @settings = Settings.select("*")
    else
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def success
    session[:expires] = Time.now
    session[:uname] = request.env['REMOTE_USER']
    session[:uname] = "wallace4" if Settings.mode?(2)
    redirect_to root_url
  end
  
  def loggedout
    session[:uname] = nil
    redirect_to root_url
  end
end
