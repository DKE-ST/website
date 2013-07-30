class BrothersController < ApplicationController
  def profile
  end
  
  def show
    @brother = BrothersPersonal.find_by(uname: params[:id])
    @brother_mit = BrothersMit.find_by(uname: params[:id])
    @brother_dke = BrothersDke.find_by(uname: params[:id])
  end
end
