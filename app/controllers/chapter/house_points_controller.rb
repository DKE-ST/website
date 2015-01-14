class Chapter::HousePointsController < ApplicationController
  before_action :officer_permission, only: [:index, :new, :create]
  before_action :entry_permission, only: [:edit, :update, :destroy]
  
  def index
    @officer_breakdown = @officer.point_entry_breakdown
  end
  
  def new
    @brothers = User::Brother.name_dke_info_id_map(6)
    @entry = Chapter::HousePoint.new
  end
  
  def create
    @entry = Chapter::HousePoint.new(point_entry_params(params))
    @entry.officer_id = @officer.id
    @entry.date = Date.today
    if @entry.valid?
      @entry.save
      redirect_to officer_house_points_path(@officer.id)
    else
      @brothers = User::Brother.name_dke_info_id_map(6)
      render "new"
    end
  end
  
  def edit
    @brothers = User::Brother.name_dke_info_id_map(6)
    @entry = Chapter::HousePoint.find(params[:id])
  end
  
  def update
    @entry = Chapter::HousePoint.find(params[:id])
    if @entry.update_attributes(point_entry_params(params))
      redirect_to officer_house_points_path(@officer.id)
    else
      @brothers = User::Brother.name_dke_info_id_map(6)
      render "edit"
    end
  end
  
  def destroy
    @entry = Chapter::HousePoint.find(params[:id])
    @entry.destroy
    redirect_to officer_house_points_path(@officer.id)
  end
  
 private
 
  def officer_permission
    @officer = Chapter::Officer.find(params[:officer_id])
    unless @officer.assign_points && @me.officer?(@officer.title)
      redirect_to main_app.root_url
    end
  end
  
  def entry_permission
    entry = Chapter::HousePoint.find(params[:id])
    @officer = entry.officer
    unless @officer.assign_points && @me.officer?(@officer.title)
      redirect_to main_app.root_url
    end
  end
  
  def point_entry_params(params)
    return params.require(:chapter_house_point).permit(:dke_info_id, :value, :comment)
  end
  
end
