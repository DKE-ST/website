class BrothersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @brothers= Hash.new
    class_map = BrothersMit.select("uname, year").order("year DESC")
    name_map = BrothersPersonal.select("first_name, last_name")
    class_map.each do |user|
      @brothers[user.year] = Array.new([]) if !@brothers.include? user.year
      @brothers[user.year] << [name_map.find_by(uname: user.uname).full_name, user.uname]
    end
    @brothers.each do |key, value|
      value.sort!
    end
  end
  
  def show
    @brother = Brothers.new(params[:id])
  end
  
  def profile
    @brother = Brothers.new(@me.uname)
    @points = HousePoints.find(@me.uname)
  end
  
  def edit
    @brother = Brothers.new(params[:id])
  end
  
  def update
    @brother = Brothers.new(params[:id])
    #@brother.update_attributes(params)
    if @brother.update_attributes(params)
      flash[:success] = "Information updated"
      if @me.uname == @brother.uname
        redirect_to profile_url
      else
        redirect_to "#{brothers_url}/#{@brother.uname}"
      end
    else
      render 'edit'
    end
  end
  
  private
  
  def correct_user
    unless @me.in_group("broporn") || params[:id]==@me.uname
      flash[:error] = "You do not have acess to this page"
      redirect_to brother_url
    end
  end
end
