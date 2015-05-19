module Backup::HousePointTablesHelper
  
  def get_total(point_entries)
    total = 100
    point_entries.each do | pos, pos_entries|
      pos_entries.each do | entry |
        total += entry.value
       end
    end
    return total
  end
  
end
