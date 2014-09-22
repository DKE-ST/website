class Chapter::ResidencesController < ApplicationController
  
  def house
  end
  
  def tour
  end
  
  def index
    
  end
  
  def show
    @room = Chapter::Residence.find(params[:id])
  end
  
end
