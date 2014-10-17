module Epsilon
  module ESheetsHelper
    
    def day_select(f, meal)
      day_list = [["Monday", 1],["Tuesday", 2],["Wednesday", 3],["Thursday", 4],["Friday", 5],["Saturday", 6]]
      if meal.date.nil?
        day_options = options_for_select(day_list)
      else
        day_options = options_for_select(day_list, selected=meal.date.wday)
      end
      return f.select(:date, day_options)
    end
    
  end
end
