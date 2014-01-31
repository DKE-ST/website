class HousePointsController < ApplicationController
  
  def index
    @exec = Positions.exec_positions
    @pts_breakdown = []
    HousePoints.get_active.each do | bro_uname |
      tmp = Brothers.new(bro_uname)
      brother = {uname: bro_uname}
      brother[:name] = tmp.personal.full_name
      brother[:year] = tmp.dke.p_class
      brother[:total] = HousePoints.total_points(bro_uname)
      brother[:points] = HousePoints.get_point_breakdown(bro_uname)
      @pts_breakdown << brother      
    end
    @pts_breakdown.sort_by!{ |a| [a[:year], a[:name]]}
  end
  
  def show
    @officer = Positions.find_by(position: params[:id])
    @pts_breakdown = []
    HousePoints.get_active.each do | bro_uname |
      tmp = Brothers.new(bro_uname)
      brother = {uname: bro_uname}
      brother[:name] = tmp.personal.full_name
      brother[:year] = tmp.dke.p_class
      brother[:points] = HousePoints.get_point_breakdown(bro_uname)[@officer.position]
      @pts_breakdown << brother      
    end
    @pts_breakdown.sort_by!{ |a| [a[:year], a[:name]]}
  end
  
end
