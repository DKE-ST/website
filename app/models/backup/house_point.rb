class Backup::HousePoint < Backup
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  belongs_to :officer, class_name: "Chapter::Officer"
  self.primary_key = "id"
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
  
  def self.officers
    officers = Hash.new
    self.select("officer_id").distinct.each do | entry |
      if entry.officer.nil?
        officers[entry.officer_id] = "unknown"
      else
        officers[entry.officer_id] =  entry.officer.name
      end
    end
    return officers
  end
  
  def self.restore_all
    #Check for unknown officers
    self.select("officer_id").distinct.each do |off|
      if off.officer.nil?
        self.where(officer_id: off.officer_id).each do | entry |
          entry.destroy
        end
      end
    end
    #Check for unknown brothers
    self.select("dke_info_id").distinct.each do | bro |
      if bro.dke_info.nil?
        self.where(dke_info_id: bro.dke_info_id).each do | entry |
          entry.destroy
        end
      end
    end
    origin = "#{Rails.configuration.database_configuration[Rails.env]['database']}.#{Chapter::HousePoint.table_name}"
    Backup::HousePoint.connection.execute("INSERT INTO #{origin} SELECT * from #{self.table_name}")
  end
  
  def self.destroy_all
    Backup::HousePoint.connection.execute("DROP TABLE #{self.table_name}")
  end
  
end
