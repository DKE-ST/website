class EpsilonController < AuthController
  before_action :on_meal_plan, only: [:e_sheet, :sign_up]

  def e_sheet
    @week_meals = Epsilon.get_week
  end
  
  def sign_up
    if sign_up_params.key? :sign_up
      meal = Epsilon.find_by(date: sign_up_params[:date], e_type: sign_up_params[:sign_up])
      key = get_key(sign_up_params[:date].to_date, sign_up_params[:sign_up])
      if Time.now - 900 > Time.parse(Settings.find(key).val, sign_up_params[:date].to_date)
        flash[:error] = "It is too late to sign up to serve this meal.  Please Contact the Epsilon"
      else
      meal.uname = @me.uname
      meal.save
      end
    else
      meal = Epsilon.find_by(date: sign_up_params[:date], e_type: sign_up_params[:drop])
      key = get_key(sign_up_params[:date].to_date, sign_up_params[:drop])
      if meal.uname != @me.uname
        flash[:error] = "You cannot unsign up another brother"
      elsif Time.now + 300 > Time.parse(Settings.find(key).val, sign_up_params[:date].to_date)
        flash[:error] = "It is too late to unsign up to serve this meal.  Please Contact the Epsilon"
      else
        meal.uname = ""
        meal.save
      end
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
    params.require(:meal).permit(:date,:sign_up,:drop)
  end
  
  def on_meal_plan
    unless @me.meal_plan?
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
end
