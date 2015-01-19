class Epsilon::Backup::EDataTable < Backup
  #id  int(11)
  #start_date  date
  #end_date  date
  #created_at  datetime
  #updated_at  datetime
  
  def self.clear_and_backup
    return false if Epsilon::ESheet.select("dke_info_id").distinct.count == 0
    entry = self.new
    entry.start_date = Epsilon::ESheet.minimum("created_at")
    entry.end_date = Epsilon::ESheet.maximum("updated_at")
    entry.save!
    table_name = "#{Epsilon::Backup::EData.base_table_name}_#{entry.id}"
    origin = "#{Rails.configuration.database_configuration[Rails.env]['database']}.#{Epsilon::ESheet.table_name}"
    Epsilon::Backup::EData.connection.execute("CREATE TABLE #{table_name} AS SELECT * from #{origin}")
    Epsilon::ESheet.destroy_all
    return true
  end
  
  def restore
    Epsilon::Backup::EDataTable.clear_and_backup
    Epsilon::Backup::EData.set_table_id(self.id)
    Epsilon::Backup::EData.restore_all
    self.destroy
    return true
  end
  
  def destroy
    Epsilon::Backup::EData.set_table_id(self.id)
    Epsilon::Backup::EData.destroy_all
    super
    return true
  end
  
end
