class HousePoints::PointEntriesController < AuthenticationController
  before_action :officer_permission, only: [:index, :new, :create]
  
  def index
    
  end
  
  def new
    @brothers = User::Brother.name_dke_info_id_map
    @entry = HousePoints::Entry.new
  end
  
  def create
    @entry = HousePoints::Entry.new(point_entry_params(params))
    @entry.officer_id = @officer.id
    if @entry.valid?
      @entry.save
      redirect_to point_entries_path(@officer.id)
    else
      @brothers = User::Brother.name_dke_info_id_map
      render "new"
    end
  end
  
 private
 
  def officer_permission
    @officer = Chapter::Officer.find(params[:officer_id])
    unless @officer.assign_points && @me.officer?(@officer.title)
      redirect_to main_app.root_url
    end
  end
  
  def point_entry_params(params)
    return params.require(:entry).permit(:dke_info_id, :value, :comment)
  end
  
end