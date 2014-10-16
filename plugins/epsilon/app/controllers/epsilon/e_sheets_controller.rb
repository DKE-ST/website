class Epsilon::ESheetsController < AuthenticationController
  
  def index
    @meals_schedule = Epsilon::ESheet.weekly_schedule
  end
  
  def show
    @meal_template = Epsilon::ESheet.find(params[:id])
  end
  
end
