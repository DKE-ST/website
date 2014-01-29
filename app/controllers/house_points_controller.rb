class HousePointsController < ApplicationController
  
  def index
    
  end
  
  def show
    @officer = Positions.find_by(position: params[:id])
  end
  
end
