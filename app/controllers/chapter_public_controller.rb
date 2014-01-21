class ChapterPublicController < ApplicationController
  
  def home
  end
  
  def about
  end
  
  def president_letter
    @content = ChapterPublic.find_by(pname: "letter")
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
  
  def summer_app
    @boarder = SummerApp.new
  end
  
  def submit_app
    info = params.require(:summer_app).permit(:first_name, :last_name, :email, :phone, :school, :year, :dke_brother, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :room_pref, :finding, :lived_before, :car)
    @boarder = SummerApp.new(info)
    @boarder.date = Date.current
    if @boarder.valid?
      @boarder.save
    else
      render "summer_app"
    end
  end
  
  def index
    @boarders = SummerApp.select("ID, first_name, last_name, email, school, year, dke_brother")
  end
  
  def show
    @boarder = SummerApp.find(params[:id])
  end
  
  def destroy
    @boarder = SummerApp.find(params[:id])
    @boarder.destroy
    flash[:success] = "Application has been destroyed."
    redirect_to chapter_public_index_path
  end
  
  private
  
  def correct_user
    
    unless @me.in_group(ChapterPublic.find_by(pname: params[:id]).user)
      flash[:error] = "You do not have acess to this page"
      redirect_to chapter_public_url
    end
  end
  
end
