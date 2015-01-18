class CreateEpsilonBackupEDataTables < ActiveRecord::Migration
  def connection
    ActiveRecord::Base.establish_connection("backup_#{Rails.env}").connection
  end
  
  def change
    create_table :epsilon_backup_e_data_tables do |t|
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
    ActiveRecord::Base.establish_connection(Rails.env).connection
  end
end
