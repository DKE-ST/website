class Epsilon < ActiveRecord::Base
  self.table_name = "e_sheets"
  #id: integer
  #date: date
  validates :date,  format: {with: /\A20\d{2}-(0[1-9]|1[0-2])-([0-2]\d|3[01])\z/}
  #time: string
  validates :time,  format: {with: /\A([1-9]|1[0-2]):[0-5]\d(AM|PM)\z/}
  #e_type: string
  #uname: string
  #value: float
  validates :value, numericality: true
  #comment: text
  
  def self.new_week(start_date = Date.current)
    start_date += 7 - start_date.days_to_week_start
    return false if Epsilon.exists?(date: start_date)
    for i in 0..5
      if i < 5
        for j in 0..2
          lunch = Epsilon.new(date: start_date + i)
          lunch.time = Settings.find("lunch_#{j}").val
          lunch.e_type = "lunch"
          lunch.value = Settings.find("dlunch_wkdy").val.to_f
          lunch.save
        end
      else
        lunch = Epsilon.new(date: start_date + i)
        lunch.time = Settings.find("lunch_wknd").val
        lunch.e_type = "lunch"
        lunch.value = Settings.find("dlunch_wknd").val.to_f
        lunch.save
      end
      for j in 0..((i<5)?1:0)
        dinner = Epsilon.new(date: start_date + i)
        dinner.e_type = "dinner"
        dinner.time = Settings.find("dinner_wk#{(i<5)?'dy':'nd'}").val
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
      meals[day] = [Epsilon.where(date: date+i).where(e_type: "lunch")]
      meals[day] << Epsilon.where(date: date+i).where(e_type: "dinner")
    end
    return meals
  end
  
  def self.get_all_meals
    meals = []
    working = Epsilon.except(e_type: "other")
    week = working.minimum("date")
    week -= week.days_to_week_start
    max = working.maximum("date")
    while week < max
      meals << [week,Epsilon.get_week(week)]
      week += 7
    end
    meals.sort_by!{ |a| [max-a[0]]}
    return meals
  end
  
end
