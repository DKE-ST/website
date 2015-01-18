class Backup < ActiveRecord::Base
  self.abstract_class = true
  self.table_name_prefix = "backup_"
  establish_connection "backup_#{Rails.env}"
end
