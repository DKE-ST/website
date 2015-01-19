class Epsilon::Backup::EDataTablesController < AuthenticationController
  before_action -> {holds?(["epsilon"])}
  
  def index
    @tables = Epsilon::Backup::EDataTable.select("*")
  end
  
  def show
    @table = Epsilon::Backup::EDataTable.find(params[:id])
    Epsilon::Backup::EData.set_table_id(@table.id)
    @breakdown = Epsilon::Backup::EData.breakdown
  end
  
  def destroy
    @table = Epsilon::Backup::EDataTable.find(params[:id])
    @table.destroy
    flash[:success] = "E data destroyed"
    redirect_to main_app.backup_e_data_tables_path
  end
  
  def update
    @table = Epsilon::Backup::EDataTable.find(params[:id])
    @table.restore
    flash[:success] = "E data recovered"
    redirect_to main_app.backup_e_data_tables_path
  end
end
