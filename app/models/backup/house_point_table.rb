class Backup::HousePointTable < Backup
  #id  int(11)
  #start_date  date
  #end_date  date
  #created_at  datetime
  #updated_at  datetime
  
  def self.clear_and_backup
    return false if Chapter::HousePoint.count == 0
    entry = self.new
    entry.start_date = Chapter::HousePoint.minimum("created_at")
    entry.end_date = Chapter::HousePoint.maximum("updated_at")
    entry.save!
    table_name = "#{Backup::HousePoint.base_table_name}_#{entry.id}"
    origin = "#{Rails.configuration.database_configuration[Rails.env]['database']}.#{Chapter::HousePoint.table_name}"
    Backup::HousePoint.connection.execute("CREATE TABLE #{table_name} AS SELECT * from #{origin}")
    Chapter::HousePoint.destroy_all
    return true
  end
  
  def restore
    Backup::HousePointTable.clear_and_backup
    Backup::HousePoint.set_table_id(self.id)
    Backup::HousePoint.restore_all
    self.destroy
  end
  
  def destroy
    Backup::HousePoint.set_table_id(self.id)
    Backup::HousePoint.destroy_all
    super
  end
  
end
