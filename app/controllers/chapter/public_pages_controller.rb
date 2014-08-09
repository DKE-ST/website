class Chapter::PublicPagesController < ApplicationController
  before_action :correct_user , only: [:edit,:update]
  
  def home
  end
  
  def show
    @content = Chapter::PublicPage.find_by(pname: params[:id])
  end
  
  def edit
    @content = Chapter::PublicPage.find_by(pname: params[:id])
  end
  
  def update
    @content = Chapter::PublicPage.find_by(pname: params[:id])
    if @content.update(update_page_params)
      redirect_to "#{public_pages_path}#{params[:id]}"
    else
      render "edit"
    end
  end
  
  def contact
    @officers = Chapter::Position.contact_info
  end
  
 private
 
  def update_page_params
    params.require(:chapter_public).permit(:title,:content)
  end
  
  def correct_user
    page = Chapter::PublicPage.find_by(pname: params[:id])
    unless page.can_edit(@me)
      flash[:error] = "You do not have acess to this page"
      redirect_to "#{root_url}#{params[:id]}"
    end
  end
  
end
