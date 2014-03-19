class SummerHousingController < ApplicationController
  before_action :correct_user , only: [:destroy]
  before_action :pledge , only: [:index, :show]
  
  def summer_housing
    @content = ChapterPublic.find_by(pname: "s_letter")
  end
  
  def summer_app
    @boarder = SummerApp.new
    @chapter_roles = ChapterPublic.gen_chapter_roles
  end
  
  def submit_app
    info = params.require(:summer_app).permit(:first_name, :last_name, :email, :phone, :school, :year, :dke_brother, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :room_pref, :finding, :lived_before, :car)
    @boarder = SummerApp.new(info)
    @boarder.date = Date.current
    if @boarder.valid?
      @boarder.save
    else
      @chapter_roles = ChapterPublic.gen_chapter_roles
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
    unless @me.is?("s_psi")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def pledge
    unless @me.pledge?
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
end
  
end
