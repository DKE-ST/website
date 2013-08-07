class UsersController < ApplicationController
  
  def index
    @brothers= Hash.new
    class_map = BrothersDke.select("uname, p_class").order("p_class DESC")
    name_map = BrothersPersonal.select("first_name, last_name")
    class_map.each do |user|
      @brothers[user.p_class] = Array.new([]) if !@brothers.include? user.p_class
      @brothers[user.p_class] << [name_map.find_by(uname: user.uname).full_name, user.uname]
    end
    @brothers.each do |key, value|
      value.sort!
    end
  end
  
  def new
    @user = Users.new
  end
  
  def show
    @user = Users.new(params[:id])
  end

  def create
    @user = Users.new(params[:users])
    status = @user.create
    if status.nil?
      redirect_to users_url
    else
      flash[:fail] = status unless status.empty?
      render "new"
    end
  end

  def update
    @user = Users.new(params[:id])
    if @user.group != "dkeaffil"
      if @user.update(params)
        flash[:success] = "Information updated"
        redirect_to users_url
      else
        render "show"
      end
    end
  end
  
  def destroy
    @user = Users.new(params[:id])
    @user.personal.destroy if @user.personal
    @user.mit.destroy if @user.mit
    @user.dke.destroy if @user.dke
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
end
