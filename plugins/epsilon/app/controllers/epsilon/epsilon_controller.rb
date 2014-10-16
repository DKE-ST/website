class Epsilon::EpsilonController < AuthenticationController
  before_action ->{holds?(["epsilon"])}
  
  def meal_schedule
    @meals_schedule = Epsilon::ESheet.weekly_schedule
  end
  
  def meal_template
    @meal_template = Epsilon::ESheet.find(params[:id])
  end
  
end
