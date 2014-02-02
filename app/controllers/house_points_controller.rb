class HousePointsController < AuthController
  before_action :correct_officer, only: :show
  before_action :correct_officer_id, only: [:edit,:destroy,:update]
  
  def index
    @award_pos = Positions.positions_awarding
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
  
  def edit
    @entry = HousePoints.find(params[:id])
    @name = BrothersPersonal.find_by(uname: @entry.uname).full_name
  end
  
  def destroy
    @entry = HousePoints.find(params[:id])
    @entry.destroy
    flash[:success] = "Entry has been deleted"
    redirect_to "#{house_points_path}/#{@entry.position}"
  end
  
 private
 
  def correct_officer
    unless @me.is?(params[:id])
      flash[:error] = "You do not have acess to this page"
      redirect_to house_points_path
    end
  end
  
  def correct_officer_id
    unless @me.is?(HousePoints.find(params[:id]).position)
      flash[:error] = "You do not have acess to this page"
      redirect_to house_points_path
    end
  end
  
end
