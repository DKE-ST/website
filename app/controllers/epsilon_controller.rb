class EpsilonController < AuthController
  before_action :on_meal_plan, only: [:e_sheet, :sign_up]
  before_action :kappa, only: [:meal_plan, :meal_plan_update]
  
  def meal_plan
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
    tmp = BrothersDke.find_by(uname: meal_plan_params[1])
    tmp.meal_plan = (meal_plan_params[0]=="add")
    tmp.save
    redirect_to meal_plan_path
  end

  def e_sheet
    @week_meals = Epsilon.get_week
  end
  
  def sign_up
    delay = [-900,300]
    ind = (sign_up_params[:action]=="add")?0:1
    meal = Epsilon.find_by(date: sign_up_params[:date], e_type: sign_up_params[:time])
    key = get_key(sign_up_params[:date].to_date, sign_up_params[:time])
    if ind==1 && meal.uname != @me.uname
      flash[:error] = "You cannot unsign up another brother"
    elsif Time.now + delay[ind] > Time.parse(Settings.find(key).val, sign_up_params[:date].to_date)
      flash[:error] = "It is too late to sign up to serve this meal.  Please Contact the Epsilon" if ind==0
      flash[:error] = "It is too late to unsign up to serve this meal.  Please Contact the Epsilon" if ind==1
    else
      meal.uname = (ind==0)?(@me.uname):("")
      meal.save
    end
    @week_meals = Epsilon.get_week
    render "e_sheet"
  end
  
 private
 
 def get_key(date, e_type)
   return (date.wday<6)?e_type:"lunch_wknd" if e_type =~ /lunch/
   return (date.wday<6)?"dinner_wkdy":"dinner_wknd" if e_type =~ /dinner/
   raise "Unknow meal time"
 end
 
  def sign_up_params
    params.require(:meal).permit(:date,:time,:action)
  end
  
  def meal_plan_params
    params.permit(:drop, :add).each do | action, uname|
      return [action, uname]
    end
  end
  
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
end
