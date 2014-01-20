class HouseRoomsController < ApplicationController
  
  def index
    
  end
  
  def show
    if params[:id] == "tour"
      @rooms = HouseRooms.select("floor, id, name")
      render "tour"
    else
      @room = HouseRooms.find(params[:id])
    end
  end
  
end