class AuthenticationController < ApplicationController
  before_action :logged_in
  
 private
  
  def beta_sigma
   unless @me.officer?("beta") || @me.officer?("sigma") || @me.admin?("brochicken")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def broporn_permissions
    unless @me.admin?("broporn")
      flash[:error] = "You do not have acess to this page"
      redirect_to brother_url
    end
  end
  
  def logged_in
    unless @me.group?("dkepledge")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
