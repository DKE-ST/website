class Backup::HousePoint < Backup
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  belongs_to :officer, class_name: "Chapter::Officer"
  #id  int(11)
  #dke_info_id   int(11)
  #officer_id  int(11)
  #value   float
  #comment   varchar(255)
  #date  date
  
  def self.base_table_name
    return "backup_house_points"
  end
  
  def self.set_table_id(id)
    self.table_name = "#{self.base_table_name}_#{id}"
  end
  
end
