module Epsilon
  module Backup::EDataTablesHelper
    
    def get_total(e_entries)
      total = 0
      e_entries.each do | entry |
        total += entry.value
      end
      return total
    end
    
  end
end
