class Chapter::BrothersController < ApplicationController
  
  def index
    @brothers = User::Brother.get_indexes
  end
  
  def show
    @brother = User::Brother.find(params[:id])
  end
  
end
