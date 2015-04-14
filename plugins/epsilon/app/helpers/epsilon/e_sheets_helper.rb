module Epsilon
  module ESheetsHelper
    
    def get_e_week
      day = Date.today + 1
      return day - day.days_to_week_start
    end
    
    def get_server(meal)
      if meal.dke_info.nil?
        time = Time.now + Epsilon::ESheet.delays[0] < Time.parse(meal.time, meal.date)
        if !time
          return "Meal Missed"
        elsif @me.brother.nil?
          out = hidden_field_tag("meal[action]", "add")
          out += password_field_tag("mit_id", "", class: "add_mit_id")
          return out
        else
          return button_tag("Sign Up" , name: "meal[action]" , value: "add")
        end
      else 
        time = Time.now + Epsilon::ESheet.delays[1] < Time.parse(meal.time, meal.date)
        name = meal.dke_info.brother.full_name
        if !time
          return name
        elsif @me.brother.nil?
          out = hidden_field_tag("meal[action]", "drop")
          out += password_field_tag("mit_id", "", class: "drop_mit_id")
          return "#{name} #{out}".html_safe
        elsif meal.dke_info_id != @me.brother.dke_info.id
          return name
        else
          drop = button_tag("Drop" , name: "meal[action]" , value: "drop")
          return "#{name} #{drop}".html_safe
        end
      end
    end
    
  end
end
