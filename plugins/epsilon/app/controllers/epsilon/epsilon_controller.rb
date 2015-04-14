class Epsilon::EpsilonController < AuthenticationController
  before_action ->{holds?(["epsilon"])}
  
  def backup_and_clear
    if Epsilon::Backup::EDataTable.clear_and_backup
      Epsilon::ESheet.gen_template_schedule
      flash[:success] = "New semester started"
    else
      flash[:error] = "No data to backup"
    end
    redirect_to epsilon_index_path
  end
  
  def create
    @element = Epsilon::ESheet.new(e_sheet_params(params))
    #Check if meal before week has been generated
    first_of_week = @element.first_of_week?
    if first_of_week
      flash[:error] = "This week's meals have not been generated yet."
    end
    if @element.valid? && !first_of_week
      @element.save
      flash[:success] = "#{@element.e_type.humanize} Created"
      redirect_to epsilon_index_path
    else
      @brothers = User::Brother::DkeInfo.list_dropdown({"meal_plan" => true})
      if @element.e_type == "entry"
        render "new"
      else
        render "new_meal"
      end
    end
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
    @element = Epsilon::ESheet.new(date: Date.today)
    @brothers = User::Brother::DkeInfo.list_dropdown({"meal_plan" => true})
  end
  
  def new_meal
    @element = Epsilon::ESheet.new(date: Date.today)
    @brothers = User::Brother::DkeInfo.list_dropdown({"meal_plan" => true})
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
    @brothers = User::Brother::DkeInfo.list_dropdown({"meal_plan" => true})
    case @element.e_type
    when "entry"
      render "edit_other"
    when /lunch|dinner/
      render "edit_meal"
    else
      redirect_to epsilon_index_path
    end
  end
  
  def update
    @element = Epsilon::ESheet.find(params[:id])
    if @element.update_attributes(e_sheet_params(params))
      flash[:success] = "#{@element.e_type.humanize} Updated"
      redirect_to epsilon_index_path
    else
      @brothers = User::Brother::DkeInfo.list_dropdown({"meal_plan" => true})
      if @element.e_type == "entry"
        render "edit_other"
      else
        render "edit_meal"
      end
    end
  end
  
  def update_e_count
    Epsilon::ESheet.update_e_count(params[:e_count])
    redirect_to epsilon_index_path
  end
  
 private
  
  def e_sheet_params(params)
    return params.require(:e_sheet).permit(:e_type, :date, :time, :dke_info_id, :value, :comment)
  end
  
end
