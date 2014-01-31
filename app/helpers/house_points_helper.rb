module HousePointsHelper
  
  def print_type(type)
    if type =~ /\S+_[sf]/
      tmp = type.gsub("_s", " Spring").gsub("_f", " Fall")
      return tmp.humanize.html_safe
    end
  end
  
  def delete_text(usr, entry)
    output = "Are you sure you want to delete this entry?\n"
    output += "*#{usr[:name]}: #{entry.value} ~ #{entry.comment}" 
    return output
  end
  
end
