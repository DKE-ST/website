class Chapter::BrothersController < ApplicationController
  skip_before_filter :logged_in, only: [:index, :show]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @brothers = User::Brother.get_indexes
  end
  
  def show
    @brother = User::Brother.find(params[:id])
  end
  
  def new
    @brother = User::Brother.new
  end
  
  def edit
    @brother = User::Brother.find(params[:id])
  end
  
  def update
    @brother = User::Brother.find(params[:id])
    if @brother.update_attributes(params)
      flash[:success] = "Information updated"
      redirect_to "#{brothers_url}/#{@brother.id}"
    else
      render 'edit'
    end
  end
  
 private
  
  def correct_user
    unless @me.admin?("broporn") || @me.is_brother?(params[:id])
      flash[:error] = "You do not have acess to this page"
      redirect_to brother_url
    end
  end
  
end
