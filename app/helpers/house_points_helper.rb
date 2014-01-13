module HousePointsHelper
  
  def print_type(type)
    if type =~ /\S+_[sf]/
      tmp = type.gsub("_s", " Spring").gsub("_f", " Fall")
      return tmp.humanize.html_safe
    end
  end
  
end
