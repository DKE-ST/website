class Chapter::ResidencesController < ApplicationController
  
  def room_picks
    @residences = Chapter::Residence.list_all("capacity >= 1 && floor > 2")
  end
  
  def mass_update
    Chapter::Residence.room_picks(params)
    redirect_to residences_path
  end
  
  def house
  end
  
  def tour
  end
  
  def index
    @residences = Chapter::Residence.list_all
  end
  
  def show
    @room = Chapter::Residence.find(params[:id])
  end
  
  def edit
    @room = Chapter::Residence.find(params[:id])
  end
  
  def update
    @room = Chapter::Residence.find(params[:id])
    if @room.update_attributes(params)
      redirect_to residences_path
    else
      render 'edit'
    end
  end
  
end
