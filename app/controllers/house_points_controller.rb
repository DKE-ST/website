class HousePointsController < AuthController
  before_action :correct_officer, only: :show
  before_action :correct_officer_id, only: [:edit,:destroy,:update]
  before_action :can_award_points, only: [:new,:create]
  
  def index
    @award_pos = Positions.positions_awarding
    @pts_breakdown = []
    HousePoints.get_active.each do | bro_uname |
      tmp = Brothers.new(bro_uname)
      brother = {uname: bro_uname}
      brother[:name] = tmp.personal.full_name
      brother[:year] = tmp.dke.p_class
      tmp_year = tmp.dke.p_class - (Date.current.year + 1)
      if tmp.mit.year - Date.current.year == 0
        tmp_year = -1
      end
      brother[:y_order] = (tmp_year + 2 * [0,tmp_year].min).abs 
      brother[:total] = HousePoints.total_points(bro_uname)
      brother[:points] = HousePoints.get_point_breakdown(bro_uname)
      @pts_breakdown << brother      
    end
    @pts_breakdown.sort_by!{ |a| [a[:y_order], 0-a[:total], a[:name]]}
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
  
  def new
    @entry = HousePoints.new
    @entry.uname = params[:uname] if params[:uname]
    @entry.position = params[:id] if params[:id]
    @brothers = Brothers.brother_list
    @positions = []
    Positions.positions_awarding.each do | pos|
      if @me.is?(pos)
        @positions << [pos.humanize, pos]
      end
    end
  end
  
  def create
    @entry = HousePoints.new(house_points_params)
    @entry.date = Date.current
    if @entry.valid?
      @entry.save
      flash[:success] = "Entry has been created"
      redirect_to "#{house_points_path}/#{@entry.position}"
    else
      @brothers = Brothers.brother_list
      @positions = []
      Positions.positions_awarding.each do | pos|
        if @me.is?(pos)
          @positions << [pos.humanize, pos]
        end
      end
      render "new"
    end
  end
  
  def edit
    @entry = HousePoints.find(params[:id])
    @name = BrothersPersonal.find_by(uname: @entry.uname).full_name
    @brothers = Brothers.brother_list
  end
  
  def update
    @entry = HousePoints.find(params[:id])
    point_params = house_points_params
    @entry.uname = point_params[:uname]
    @entry.value = point_params[:value]
    @entry.comment = point_params[:comment]
    if @entry.valid?
      @entry.date = Date.current
      @entry.save
      flash[:success] = "Entry has been updated"
      redirect_to "#{house_points_path}/#{@entry.position}"
    else
      @name = BrothersPersonal.find_by(uname: @entry.uname).full_name
      @brothers = Brothers.brother_list
      render "edit"
    end
  end
  
  def destroy
    @entry = HousePoints.find(params[:id])
    @entry.destroy
    flash[:success] = "Entry has been deleted"
    redirect_to "#{house_points_path}/#{@entry.position}"
  end
  
 private
 
  def house_points_params
    return params.require(:house_points).permit(:uname,:position,:value,:comment)
  end
 
 def can_award_points
   if params[:id] && !@me.is?(params[:id])
      flash[:error] = "You do not have acess to this page"
      redirect_to house_points_path
    end
   pass = false
   Positions.positions_awarding.each do | pos |
     if @me.is?(pos)
       pass = true
       break
     end
   end
   unless pass
     flash[:error] = "You do not have acess to this page"
     redirect_to house_points_path
   end
 end
  
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
