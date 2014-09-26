class Chapter::BrothersController < AuthenticationController
  skip_before_filter :logged_in, only: [:index, :show]
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
      redirect_to new_brother_path + "?big_id=" + @brother.dke_info.id.to_s if params[:little_ids].include?("new")
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
