module Chapter::HousePointsHelper
  
  def humanize(date)
    return date.strftime("%m/%e/%y")
  end
  
  def brother_total(entries)
    total = 0
    entries.each do | entry |
      total += entry.value
    end
    return total
  end
  
  def delete_text(brother, entry)
    output = "Are you sure you want to delete this entry?\n"
    output += "*#{brother[:first]} #{brother[:last]}: #{entry.value} ~ #{entry.comment}" 
    return output
  end
  
end
