class SummerHousingController < AuthenticationController
  skip_before_action :logged_in, only: [:summer_housing, :new, :create]
  before_action :display?, only: [:new, :create]
  before_action -> {holds?(["s_psi"])}, only: [:destroy, :update, :summer_housing_edit]
  
  def summer_housing_edit
    @content = Chapter::PublicPage.find_by(pname: "summer_housing")
  end
  
  def summer_housing
    @content = Chapter::PublicPage.find_by(pname: "summer_housing")
  end
  
  def new
    @boarder = SummerHousingApplication.new
    @chapter_roles = Chapter.gen_chapter_roles
  end
  
  def create
    @boarder = SummerHousingApplication.new(summer_app_filter(params))
    if @boarder.valid?
      @boarder.save
    else
      @chapter_roles = Chapter.gen_chapter_roles
      render "new"
    end
  end
  
  def index
    @boarders = SummerHousingApplication.select("id, first_name, last_name, email, school, year, dke_brother, created_at, contacted")
    if params[:sorting].nil?
      @boarders = @boarders.order(contacted: :asc, created_at: :desc)
    else
      @boarders = @boarders.order("#{params[:sorting]} #{params[:asc]}")
    end
  end
  
  def show
    @boarder = SummerHousingApplication.find(params[:id])
  end
  
  def destroy
    @boarder = SummerHousingApplication.find(params[:id])
    @boarder.destroy
    flash[:success] = "Application has been destroyed."
    redirect_to summer_apps_path
  end
  
  def update
    @boarder = SummerHousingApplication.find(params[:id])
    @boarder.contacted = !@boarder.contacted
    @boarder.save
    #flash[:success] = "Boarder had been updated."
    #redirect_to summer_apps_path
    render text: (@boarder.contacted)?"Yes":"No"
  end
  
 private
  
  def summer_app_filter(params)
    return params.require(:summer_housing_application).permit(:first_name, :last_name, :sex, :age, :email, :phone, :school, :year, :dke_brother, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :room_pref, :finding, :lived_before, :car)
  end
  
  def display?
    unless SummerHousingApplication.display?
      flash[:warning] = "Summer Housing Application is not currently open"
      redirect_to root_url
    end
  end
  
end
