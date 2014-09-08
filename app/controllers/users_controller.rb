class UsersController < AuthenticationController
  
  def index
    @users = User.list
  end
  
  def filter
    @users = User.list(filter_params(params))
    render partial: 'filter', object: @users
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
 private
 
  def filter_params(params)
    return params.permit("group", "year", "house", "admin")
  end
  
end