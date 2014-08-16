class AuthenticationController < ApplicationController
  before_action :logged_in
  
 private
  
  def logged_in
    unless @me.group?("dkepledge")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
