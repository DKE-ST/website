class ChapterPublicController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def contact
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      if pos.disp && !pos.uname.empty?
        name = BrothersPersonal.find_by(uname: pos.uname).full_name
        year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
        @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name}
      end
    end
  end
  
  def show
    if params[:id] !~ /house.*/
      @content = ChapterPublic.find_by(pname: params[:id])
      render params[:id]
    elsif params[:id] == "house"
      @rooms = HouseRooms.select("floor, id, name")
      render "house"
    else
      @room = HouseRooms.find(params[:id][/\Ahouse-\d\d\d\z/][/\d\d\d/])
      render "room"
    end
  end
  
  private
  
  def correct_user
    
    unless @me.in_group(ChapterPublic.find_by(pname: params[:id]).user)
      flash[:error] = "You do not have acess to this page"
      redirect_to chapter_public_url
    end
  end
  
end
