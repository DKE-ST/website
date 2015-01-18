module Backup::HousePointTablesHelper
  
  def humanize(date)
    return date.strftime("%B %e, %Y")
  end
  
end
