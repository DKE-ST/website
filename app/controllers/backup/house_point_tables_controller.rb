class Backup::HousePointTablesController < AuthenticationController
  before_action ->{holds?(["beta"])}
  
  def index
    @tables = Backup::HousePointTable.select("*")
  end
  
  def show
    @table = Backup::HousePointTable.find(params[:id])
    Backup::HousePoint.set_table_id(@table.id)
    @breakdown = Backup::HousePoint.breakdown
  end
  
  def destroy
    @table = Backup::HousePointTable.find(params[:id])
    @table.destroy
    flash[:success] = "House Point data destroyed"
    redirect_to backup_house_point_tables_path
  end
  
  def update
    @table = Backup::HousePointTable.find(params[:id])
    @table.restore
    flash[:success] = "House Point data restored"
    redirect_to backup_house_point_tables_path
  end
  
end
