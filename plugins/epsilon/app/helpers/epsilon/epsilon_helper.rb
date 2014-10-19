module Epsilon
  module EpsilonHelper
    
    def get_serv(meal)
      if meal.dke_info.nil?
        time = Time.now - 900 < Time.parse(meal.time, meal.date)
        return "Meal Missed" unless time
      else 
        return meal.dke_info.brother.full_name
      end
    end
    
    def disp_meal(meal)
      pt1 = "#{meal.e_type.humanize} #{meal.time} ::"
      time = Time.now - 900 < Time.parse(meal.time, meal.date)
      if meal.dke_info.nil?
        return "#{pt1} Meal Missed" unless time
        return pt1
      else 
        name = meal.dke_info.brother.full_name
        return "#{pt1} #{name} -- #{meal.value}" if  Time.now > Time.parse(meal.time, meal.date)
        return "#{pt1} #{name}"
      end
    end
    
    def disp_other(entry, path)
      name = entry.dke_info.brother.full_name
      main = link_to "#{name} :: #{entry.value}" , "#{path}/#{entry.id}"
      cmt = "&nbsp;&nbsp;-- #{entry.comment}"
      return "#{main}<br>#{cmt}".html_safe
    end
    
  end
end
