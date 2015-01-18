class CreateEpsilonBackupEData < ActiveRecord::Migration
  def change
    create_table :epsilon_backup_e_data do |t|

      t.timestamps
    end
  end
end
