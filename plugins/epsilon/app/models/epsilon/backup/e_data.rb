class Epsilon::Backup::EData < Backup
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  self.primary_key = "id"
  #id  int(11)
  #dke_info_id   int(11)
  #date  date
  #time  time
  #e_type  varchar(8)
  #value   float
  #comment   text
  #created_at  datetime
  #updated_at  datetime
  
  def self.base_table_name
    return "epsilon_backup_e_data"
  end
  
  def self.set_table_id(id)
    self.table_name = "#{self.base_table_name}_#{id}"
  end
  
  def self.breakdown
    breakdown = Hash.new
    self.select("dke_info_id").distinct.each do | per |
      if per.dke_info
        breakdown[per.dke_info_id] = {name: per.dke_info.brother.full_name,
                                      year: per.dke_info.brother.mit_info.year,
                                      points: Hash.new}
      end
    end
    self.select("*").order(officer_id: :asc).each do | entry |
      if breakdown.include? entry.dke_info_id
        officer = self.officers[entry.officer_id]
        if breakdown[entry.dke_info_id][:points].include? officer
          breakdown[entry.dke_info_id][:points][officer] << entry
        else
          breakdown[entry.dke_info_id][:points][officer] = [entry]
        end
      end
    end
    out = []
    breakdown.each do | key, value |
      out << value
    end
    return out.sort_by!{ |a| [a[:year], a[:name]]}
  end
  
  def self.restore_all
    origin = "#{Rails.configuration.database_configuration[Rails.env]['database']}.#{Epsilon::ESheet.table_name}"
    Backup::HousePoint.connection.execute("INSERT INTO #{origin} SELECT * from #{self.table_name}")
  end
  
  def self.destroy_all
    Backup::HousePoint.connection.execute("DROP TABLE #{self.table_name}")
  end
end
