class Epsilon < ActiveRecord::Base
  self.table_name = "e_sheets"
  #id: integer
  #date: date
  #e_type: string
  #uname: string
  #value: float
  #comment: text
  
  def self.new_week(start_date = Date.current)
    start_date += 7 - start_date.days_to_week_start
    return false if Epsilon.exists?(date: start_date)
    for i in 0..5
      if i < 5
        for j in 0..2
          lunch = Epsilon.new(date: start_date + i)
          lunch.e_type = "lunch_#{j}"
          lunch.value = Settings.find("dlunch_wkdy").val.to_f
          lunch.save
        end
      else
        lunch = Epsilon.new(date: start_date + i)
        lunch.e_type = "lunch_0"
        lunch.value = Settings.find("dlunch_wknd").val.to_f
        lunch.save
      end
      for j in 0..((i<5)?1:0)
        dinner = Epsilon.new(date: start_date + i)
        dinner.e_type = "dinner_#{j}"
        dinner.value = Settings.find("d_din_wk#{(i<5)?'dy':'nd'}").val.to_f
        dinner.save
      end
    end
    return true
  end
  
  def self.get_week(date = Date.current)
    date -= date.days_to_week_start
    meals = {}
    for i in 0..5
      day = (date+i)
      meals[day] = Epsilon.where(date: date+i).except(e_type: "other")
    end
    return meals
  end
  
  
end
