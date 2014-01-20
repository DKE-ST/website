class StaticPagesController < AuthController
  before_action :auth_user, only: [:settings, :update_settings]
  
  def php_header
  end
  
  def settings
    @settings = {}
    @settings["debug"] = {db: Settings.find("debug"), options: [["Enabled",1],["Disabled",0]]}
    @settings["server"] = {db: Settings.find("server"), options: [["Production",0],["Development",1],["Local",2]]}
  end
  
  def update_settings
    config = params.require(:settings).permit(:debug, :server)
    puts config
    config.each do | name, val |
      tmp = Settings.find(name)
      tmp.val = val
      tmp.save if tmp.val_changed?
    end
    settings
    render "settings"
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
  
 private
 
 def auth_user
    unless @me.in_group("brochicken")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
