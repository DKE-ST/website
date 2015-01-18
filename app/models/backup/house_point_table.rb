class Backup::HousePointTable < Backup
  #id  int(11)
  #start_date  date
  #end_date  date
  #created_at  datetime
  #updated_at  datetime
  
  def self.clear_and_backup
    entry = self.new
    entry.start_date = Chapter::HousePoint.minimum("created_at")
    entry.end_date = Chapter::HousePoint.maximum("updated_at")
    entry.save!
    table_name = "#{Backup::HousePoint.base_table_name}_#{entry.id}"
    origin = "#{Rails.configuration.database_configuration[Rails.env]['database']}.#{Chapter::HousePoint.table_name}"
    Backup::HousePoint.connection.execute("CREATE TABLE #{table_name} AS SELECT * from #{origin}")
    Chapter::HousePoint.destroy_all
  end
  
end
