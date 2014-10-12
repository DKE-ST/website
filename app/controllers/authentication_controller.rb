class AuthenticationController < ApplicationController
  before_action :logged_in
  
 private
  
  def holds?(positions)
    auth = @me.admin?("brochicken")
    positions.each do | pos |
      auth = true if @me.officer?(pos)
    end
    unless auth
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def brochicken_permissions
    unless @me.admin?("brochicken")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def broporn_permissions
    unless @me.admin?("broporn")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def logged_in
    unless @me.group?("dkepledge")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
