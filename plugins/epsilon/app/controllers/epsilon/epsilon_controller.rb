class Epsilon::EpsilonController < AuthenticationController
  before_action ->{holds?(["epsilon"])}
  
  def meal_schedule
    @meals_schedule = Epsilon::ESheet.weekly_schedule
  end
  
end
