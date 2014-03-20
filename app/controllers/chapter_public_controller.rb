class ChapterPublicController < ApplicationController
  before_action :correct_user , only: [:edit,:update]
  
  def home
  end
  
  def show
    @content = ChapterPublic.find_by(pname: params[:id])
  end
  
  def edit
    @content = ChapterPublic.find_by(pname: params[:id])
  end
  
  def update
    @content = ChapterPublic.find_by(pname: params[:id])
    if @content.update(update_page_params)
      redirect_to "#{chapter_public_index_path}#{params[:id]}"
    else
      render "edit"
    end
  end
  
  def contact
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      if pos.disp && !pos.uname.empty?
        name = BrothersPersonal.find_by(uname: pos.uname).full_name
        year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
        @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name}
      end
    end
  end
  
 private
 
  def update_page_params
    params.require(:chapter_public).permit(:title,:content)
  end
  
  def correct_user
    user = ChapterPublic.find_by(pname: params[:id]).user
    unless @me.is?(user)
      flash[:error] = "You do not have acess to this page"
      redirect_to "#{root_url}#{params[:id]}"
    end
  end

end
