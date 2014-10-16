class Epsilon::MealPlanController < AuthenticationController
  before_action ->{holds?(["beta", "kappa", "epsilon"])}
  
  def roster
    @brothers = Epsilon::MealPlan.list
  end
  
  def filter
    @brothers = Epsilon::MealPlan.list(filter_params(params))
    render partial: 'filter', object: @brothers
  end
  
  def toggle
    @brother = Epsilon::MealPlan.find(params[:id])
    @brother.meal_plan = !@brother.meal_plan
    @brother.save
    render text: @brother.meal_plan
  end
  
 private
 
  def filter_params(params)
    return params.permit("year", "house", "meal_plan")
  end
  
end
