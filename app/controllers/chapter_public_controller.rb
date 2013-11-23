class ChapterPublicController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def contact
    @officers = Hash.new
    position_map =  BrothersDke.select("cur_pos, uname")
    position_map.each do |position|
      unless position.cur_pos == ""
        name = BrothersPersonal.find_by(uname: position.uname).full_name
        year = BrothersMit.find_by(uname: position.uname).year.to_s[2..3]
        @officers[position.cur_pos] = {uname: position.uname, full_name: name, year: year}
      end
    end
  end
  
  def show
    @content = ChapterPublic.find_by(pname: params[:id])
  end
  
  def edit
    @content = ChapterPublic.find_by(pname: params[:id])
  end
  
  def update
    @content = ChapterPublic.find_by(pname: params[:id])
    if @content.update_attributes(params.require(:chapter_public).permit(:title, :pname, :content))
      flash[:success] = "Information updated"
      redirect_to chapter_public_url
    else
      render 'edit'
    end
  end
  
  private
  
  def correct_user
    
    unless @me.in_group(ChapterPublic.find_by(pname: params[:id]).user)
      flash[:error] = "You do not have acess to this page"
      redirect_to chapter_public_url
    end
  end
  
end
