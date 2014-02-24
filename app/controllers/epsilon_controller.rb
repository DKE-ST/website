class EpsilonController < AuthController
  before_action :epsilon
  skip_before_filter :epsilon, only: [:e_sheet, :sign_up, :meal_plan, :meal_plan_update, :dan]
  skip_before_filter :logged_in, only: :dan
  before_action :on_meal_plan, only: [:e_sheet, :sign_up]
  before_action :kappa, only: [:meal_plan, :meal_plan_update]
  
  def new
    @element = Epsilon.new(date: Date.current)
    @brothers = Epsilon.meal_plan_drop
  end
  
  def new_meal
    @element = Epsilon.new(date: Date.current)
    @brothers = Epsilon.meal_plan_drop
  end
  
  def new_week
    res = Epsilon.new_week
    if res
      flash[:success] = "New Week Added"
    else
      flash[:error] = "Meals already exist for this week"
    end
    redirect_to epsilon_index_path
  end
  
  def new_semester
    EpsilonBackup.backup_e_data
    flash[:success] = "E data reset.  Previous Data stored in e_history."
    redirect_to epsilon_index_path
  end
  
  def create
    @element = Epsilon.new(update_params)
    if @element.e_type.nil?
      @element.e_type="entry"
      @element.time = Time.current.strftime("%I:%M%p")
    end
    if @element.valid?
      @element.save
      flash[:success] = "#{@element.e_type.humanize} Created"
      redirect_to epsilon_index_path
    else
      @brothers = Epsilon.meal_plan_drop
      pg = (@element.e_type=="entry")?"new":"new_meal"
      render pg
    end
  end
  
  def index
    @menu = EpsilonMenu.select("*")
    @meals = Epsilon.get_all_meals
    @threshold = Epsilon.e_count
    @entries = Epsilon.get_others
    @e_count = Epsilon.get_e_count
  end
  
  def show
    @element = Epsilon.find(params[:id])
    @brothers = Epsilon.meal_plan_drop
    pg = (@element.e_type=="entry")?"edit_other":"edit_meal"
      render pg
  end
  
  def update
    @element = Epsilon.find(params[:id])
    if @element.update_attributes(update_params)
      redirect_to epsilon_index_path
    else
      @brothers = Epsilon.meal_plan_drop
      render "edit_meal"
    end
  end
  
  def destroy
    @element = Epsilon.find(params[:id])
    @element.destroy
    flash[:success] = "Meal Deleted"
    redirect_to epsilon_index_path
  end
  
  def update_count
    e_val = params.require(:e_count)
    if e_val =~ /\A\d+.?\d*\z/
      tmp = Settings.find("e_count")
      tmp.val = e_val
      tmp.save
      flash[:success] = "E Count updated"
    else
      flash[:error] = "E's Needed is not a number"
    end
    redirect_to epsilon_index_path
  end
  
  def update_menu
    params.require(:menu).each do | day , entries |
      tmp = EpsilonMenu.find(day)
      tmp.lunch = entries[:lunch]
      tmp.dinner = entries[:dinner]
      tmp.save
    end
    redirect_to epsilon_index_path
  end
  
  ##############Meal Plan View for Kappa ##############
  
  def meal_plan
    @alums = Epsilon.get_off_meal_plan
    bros = HousePoints.get_active
    BrothersDke.where(meal_plan: 1).each do | brother |
      bros << brother.uname unless bros.index(brother.uname)
    end
    @brothers = []
    bros.each do | bro_uname |
      tmp = Brothers.new(bro_uname)
      brother = {uname: bro_uname}
      brother[:name] = tmp.personal.full_name
      brother[:year] = tmp.dke.p_class
      brother[:meal_plan] = tmp.dke.meal_plan
      @brothers << brother      
    end
    @brothers.sort_by!{ |a| [a[:year], a[:name]]}
  end
  
  def meal_plan_update
    if add_alum_params[:commit]
      tmp = BrothersDke.find_by(uname: add_alum_params[:added])
      tmp.meal_plan = 1
    else
      tmp = BrothersDke.find_by(uname: meal_plan_params[1])
      tmp.meal_plan = (meal_plan_params[0]=="add")
    end
    tmp.save
    redirect_to meal_plan_path
  end
  
  ##############Dan's View ################
  
  def dan
    @menu = EpsilonMenu.select("*")
    @week_meals = Epsilon.get_week
    @e_count = Epsilon.get_e_count
  end
  
  ##############E Sheet ##################
  
  def e_sheet
    @menu = EpsilonMenu.select("*")
    @week_meals = Epsilon.get_week
    @e_count = Epsilon.get_e_count
  end
  
  def sign_up
    delay = [-900,300]
    ind = (sign_up_params[:action]=="add")?0:1
    meal = Epsilon.find(sign_up_params[:id])
    if ind==1 && meal.uname.empty?
      flash[:error] = "No one is signed up for this meal"
    elsif ind==1 && meal.uname != @me.uname
      flash[:error] = "You cannot unsign up another brother"
    elsif ind==0 && meal.uname == @me.uname
      flash[:error] = "You already signed up to serve this meal"
    elsif ind==0 && !meal.uname.empty?
      flash[:error] = "Another brother has already signed up"
    elsif Time.now + delay[ind] > Time.parse(meal.time, meal.date)
      flash[:error] = "It is too late to sign up to serve this meal.  Please Contact the Epsilon" if ind==0
      flash[:error] = "It is too late to unsign up to serve this meal.  Please Contact the Epsilon" if ind==1
    else
      meal.uname = (ind==0)?(@me.uname):("")
      meal.save
    end
    @week_meals = Epsilon.get_week
    @e_count = Epsilon.get_e_count
    @menu = EpsilonMenu.select("*")
    render "e_sheet"
  end
  
 private
 
  def get_key(date, e_type)
    return (date.wday<6)?e_type:"lunch_wknd" if e_type =~ /lunch/
    return (date.wday<6)?"dinner_wkdy":"dinner_wknd" if e_type =~ /dinner/
    raise "Unknow meal time"
  end
  
  ############Parameter Filters #################
  
  def update_params
    return params.require(:epsilon).permit(:date,:e_type, :time, :uname, :value, :comment)
  end 
 
 
  def sign_up_params
    params.require(:meal).permit(:id,:action)
  end
  
  def add_alum_params
    return params.permit(:commit, :added)
  end
  
  def meal_plan_params
    params.permit(:drop, :add).each do | action, uname|
      return [action, uname]
    end
  end
  
  ##########User Validation Funcitons #################
  
  def on_meal_plan
    unless @me.meal_plan?
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def kappa
    unless @me.is? "kappa"
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def epsilon
    unless @me.is? "epsilon"
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
