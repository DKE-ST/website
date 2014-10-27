module Epsilon
  module ESheetsHelper
    
    def get_e_week
      day = Date.current + 1
      return day - day.days_to_week_start
    end
    
    def get_server(meal)
      if meal.dke_info.nil?
        time = Time.now - 900 < Time.parse(meal.time, meal.date)
        return "Meal Missed" unless time
        return button_tag("Sign Up" , name: "meal[action]" , value: "add")
      else 
        time = Time.now + 300 < Time.parse(meal.time, meal.date)
        name = meal.dke_info.brother.full_name
        begin
          check = meal.dke_info_id == @me.brother.dke_info.id
        rescue
          check = true
        end
        return name unless time && check
        drop = button_tag("Drop" , name: "meal[action]" , value: "drop")
        return "#{name} #{drop}".html_safe
      end
    end
    
  end
end
