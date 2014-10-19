class Epsilon::EpsilonController < AuthenticationController
  before_action ->{holds?(["epsilon"])}
  
  def create
    
  end
  
  def destroy
    @element = Epsilon::ESheet.find(params[:id])
    @element.destroy
    redirect_to epsilon_index_path
  end
  
  def index
    @meals = Epsilon::ESheet.get_all_meals
    @threshold = Epsilon::ESheet.e_count
    @entries = Epsilon::ESheet.get_others
    @e_count = Epsilon::ESheet.track_progress
  end
  
  def new
    @element = Epsilon::ESheet.new(date: Date.current)
    @brothers = Epsilon::MealPlan.list_dropdown({"meal_plan" => true})
  end
  
  def new_meal
    @element = Epsilon::ESheet.new(date: Date.current)
    @brothers = Epsilon::MealPlan.list_dropdown({"meal_plan" => true})
  end
  
  def new_week
    res = Epsilon::ESheet.new_week
    if res
      flash[:success] = "New Week Added"
    else
      flash[:error] = "Meals already exist for this week"
    end
    redirect_to epsilon_index_path
  end
  
  def show
    @element = Epsilon::ESheet.find(params[:id])
    @brothers = Epsilon::MealPlan.list_dropdown({"meal_plan" => true})
    case @element.e_type
    when "entry"
      render "edit_other"
    when /lunch|dinner/
      render "edit_meal"
    else
      redirect_to epsilon_index_path
    end
  end
  
 private
  
  def e_sheet_params(params)
    return params.require(:e_sheet)
  end
  
end
