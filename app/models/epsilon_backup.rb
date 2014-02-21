class EpsilonBackup < ActiveRecord::Base
  establish_connection "backup"
  
  def self.get_e_data(id)
    EpsilonBackup.table_name="e_data_#{id}"
    return EpsilonBackup.select("*")
  end
  
  def self.backup_e_data
    EpsilonBackup.table_name="epsilon_backups"
    max = Epsilon.maximum("date")
    min = Epsilon.minimum("date")
    entry = EpsilonBackup.new
    entry.start_date = min
    entry.end_date = max
    entry.save
    EpsilonBackup.connection.execute("CREATE TABLE e_data_#{entry.id} AS SELECT * from dke_website.e_sheets")
    Epsilon.destroy_all
  end
  
  
end
