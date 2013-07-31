class BrothersController < ApplicationController
  def profile
  end
  
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
    @brother = BrothersPersonal.find_by(uname: params[:id])
    @brother_mit = BrothersMit.find_by(uname: params[:id])
    @brother_dke = BrothersDke.find_by(uname: params[:id])
  end
end
