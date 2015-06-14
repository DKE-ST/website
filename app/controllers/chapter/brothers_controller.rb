class Chapter::BrothersController < AuthenticationController
  skip_before_action :logged_in, only: [:index, :show]
  skip_before_action :checks, only: [:update]
  before_action :correct_user, only: [:edit, :update]
  before_action :broporn_permissions, only: [:destroy]
  
  def create
    @brother = User::Brother.new(params)
    if @brother.valid?
      @brother.save
      flash[:success] = "Information updated"
      check_redirect(params[:user_brother][:dke_info], "#{brothers_path}/#{@brother.id}")
    else
      render 'new'
    end
  end
  
  def destroy
    @brother = User::Brother.find(params[:id])
    @brother.destroy
    flash[:success] = "Brother Information for #{@brother.full_name} deleted"
    redirect_to brothers_path
  end
  
  def edit
    @brother = User::Brother.find(params[:id])
  end
  
  def index
    @brothers = User::Brother.get_indexes
  end
  
  def new
    @brother = User::Brother.new
    @brother.user_id = params[:user_id]
    @brother.dke_info.big_id = params[:big_id]
    @brother.dke_info.little_ids = [params[:little_id]]
  end
  
  def show
    @brother = User::Brother.find(params[:id])
  end
  
  def update
    @brother = User::Brother.find(params[:id])
    if @brother.update_attributes(params)
      flash[:success] = "Information updated"
      if @me.status == 0
        @me.set_status(1)
      end
      check_redirect(params[:user_brother][:dke_info], brother_url)
    else
      render 'edit'
    end
  end
  
 private
 
  def check_redirect(params, redirect_path)
    if params[:big_id] == "new"
      redirect_to new_brother_path + "?little_id=" + @brother.dke_info.id.to_s
    elsif !params[:little_ids].nil?
      if params[:little_ids].include?("new")
        redirect_to new_brother_path + "?big_id=" + @brother.dke_info.id.to_s
      else
        redirect_to redirect_path
      end
    else
      redirect_to redirect_path
    end
  end
  
  def correct_user
    unless @me.is_brother?(params[:id])
      flash[:error] = "You do not have acess to this page"
      redirect_to brother_url
    end
  end
  
end
