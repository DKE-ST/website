class Chapter::HousePointsController < AuthenticationController
  before_action :assigns_points, only: :index
  before_action :officer_permission, only: [:new, :create]
  before_action :entry_permission, only: [:edit, :update, :destroy]
  before_action ->{holds?(["beta"])}, only: :backup_and_clear
  
  def backup_and_clear
    if Backup::HousePointTable.clear_and_backup
      flash[:success] = "House Points entries cleared"
    else
      flash[:error] = "House Points table is currently empty"
    end
    redirect_to officer_house_points_path(1)
  end
  
  def full_breakdown
    @officers = Chapter::Officer.where(assign_points: true).order(position: :asc)
    @breakdown = []
    User::Brother.name_dke_info_id_map(true).each do | year, brothers |
      brothers.each do | brother |
        if brother[1].is_a? Integer
          dke_info = User::Brother::DkeInfo.find(brother[1])
          yr = dke_info.p_class - User::Brother::DkeInfo.cur_p_class + 3
          @breakdown << {id: dke_info.brother_id,
                        name: brother[0],
                        year: dke_info.p_class,
                        y_order: (yr > 0)?(4 - yr):yr,
                        total: dke_info.house_point_total,
                        points: dke_info.house_point_total_breakdown}
        end
      end
    end
    @breakdown.sort_by!{ |a| [0-a[:y_order], 0-a[:total], a[:name]]}
  end
  
  def index
    @officer = Chapter::Officer.find(params[:officer_id])
    @officer_breakdown = @officer.point_entry_breakdown
  end
  
  def new
    @brothers = User::Brother.name_dke_info_id_map(true)
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
      @brothers = User::Brother.name_dke_info_id_map(true)
      render "new"
    end
  end
  
  def edit
    @brothers = User::Brother.name_dke_info_id_map(true)
    @entry = Chapter::HousePoint.find(params[:id])
  end
  
  def update
    @entry = Chapter::HousePoint.find(params[:id])
    if @entry.update_attributes(point_entry_params(params))
      redirect_to officer_house_points_path(@officer.id)
    else
      @brothers = User::Brother.name_dke_info_id_map(true)
      render "edit"
    end
  end
  
  def destroy
    @entry = Chapter::HousePoint.find(params[:id])
    @entry.destroy
    redirect_to officer_house_points_path(@officer.id)
  end
  
 private
 
 def assigns_points
    @officer = Chapter::Officer.find(params[:officer_id])
    unless @officer.assign_points 
      redirect_to main_app.root_url
    end
  end
 
  def officer_permission
    @officer = Chapter::Officer.find(params[:officer_id])
    unless @officer.assign_points && @me.officer?(@officer.name)
      redirect_to main_app.root_url
    end
  end
  
  def entry_permission
    entry = Chapter::HousePoint.find(params[:id])
    @officer = entry.officer
    unless @officer.assign_points && @me.officer?(@officer.name)
      redirect_to main_app.root_url
    end
  end
  
  def point_entry_params(params)
    return params.require(:chapter_house_point).permit(:dke_info_id, :value, :comment)
  end
  
end
