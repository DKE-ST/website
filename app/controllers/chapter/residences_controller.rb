class Chapter::ResidencesController < AuthenticationController
  before_action :beta_sigma, only: [:room_picks, :mass_update]
  before_action :broporn_permissions, only: [:index, :edit, :update]
  skip_before_filter :logged_in, only: [:house, :tour, :show]
  
  def edit
    @room = Chapter::Residence.find(params[:id])
  end
  
  def house
  end
  
  def index
    @residences = Chapter::Residence.list_all
  end
  
  def mass_update
    Chapter::Residence.room_picks(params)
    redirect_to residences_path
  end
  
  def room_picks
    @residences = Chapter::Residence.list_all("capacity >= 1 && floor > 2")
  end
  
  def show
    @room = Chapter::Residence.find(params[:id])
  end
  
  def tour
  end
  
  def update
    @room = Chapter::Residence.find(params[:id])
    if @room.update_attributes(params)
      redirect_to residences_path
    else
      render 'edit'
    end
  end
  
end
