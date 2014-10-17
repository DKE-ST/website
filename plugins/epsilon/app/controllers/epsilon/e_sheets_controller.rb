class Epsilon::ESheetsController < AuthenticationController
  
  def create
    @meal_template = Epsilon::ESheet.new(meal_template_params(params))
    if @meal_template.valid?
      @meal_template.save
      redirect_to e_sheets_path
    else
      render "new"
    end
  end
  
  def destroy
    @meal_template = Epsilon::ESheet.find(params[:id])
    @meal_template.destroy
    redirect_to e_sheets_path
  end
  
  def index
    @meals_schedule = Epsilon::ESheet.weekly_schedule
  end
  
  def new
    @meal_template = Epsilon::ESheet.new
  end
  
  def show
    @meal_template = Epsilon::ESheet.find(params[:id])
  end
  
  def update
    @meal_template = Epsilon::ESheet.find(params[:id])
    if @meal_template.update_attributes(meal_template_params(params))
      redirect_to e_sheets_path
    else
      render "show"
    end
  end
  
 private
  
  def meal_template_params(params)
    temp_params = params.require(:e_sheet).permit(:date, :time, :e_type, :value)  
    if temp_params[:date].class != Date
      temp_params[:date] = Date.new(0,1,4 + temp_params[:date].to_i)
    end
    return temp_params
  end
  
end
