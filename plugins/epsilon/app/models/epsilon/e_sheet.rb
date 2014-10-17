class Epsilon::ESheet < ActiveRecord::Base
  #id  int(11)
  #dke_info_id   int(11)
  #date  date
  #time  time
  validates :time, format: {with: /\A(0?[1-9]|1[0-2]):[0-5]\d(AM|PM)\z/}
  #e_type  varchar(8)
  validates :e_type, presence: true
  #value   float
  validates :value, presence: true, numericality: true
  #comment   text
  #created_at  datetime
  #updated_at  datetime
  
  def self.new_week(start_date = Date.current+2)
    start_date -= start_date.days_to_week_start
    return false if self.exists?(e_type: ["lunch","dinner"], date: start_date..start_date+5)
    self.weekly_schedule.each do | date, meals |
      meals.each do | meal |
        new_meal = meal.dup
        new_meal.e_type = new_meal.e_type[2..-1]
        new_meal.date = start_date + date.wday - 1
        new_meal.save
      end
    end
    return true
  end
  
  def self.get_week(date = Date.current+1)
    date -= date.days_to_week_start
    meals = {}
    for i in 0..5
      day = (date+i)
      meals[day] = [self.where(date: date+i).where(e_type: "lunch")]
      meals[day] << self.where(date: date+i).where(e_type: "dinner")
    end
    return meals
  end
  
  def self.weekly_schedule
    date = Date.new(0,1,5)
    meals = {}
    for i in 0..5
      day = (date+i)
      meals[day] = self.where(date: date+i)
      meals[day].sort_by!{ |a| [1 - a.e_type.to_i, a.time]}
    end
    return meals
  end
  
  def self.gen_template_schedule
    start_date = Date.new(0,1,5)
    return false if self.exists?(e_type: ["t_lunch","t_dinner"], date: start_date..start_date+5)
    for i in 0..5
      if i < 5
        for j in 0..2
          lunch = self.new(date: (start_date + i))
          lunch.time = ["11:30AM","12:15PM","1:15PM"][j]
          lunch.e_type = "t_lunch"
          lunch.value = 1
          lunch.save
        end
      end
      for j in 0..((i<5)?1:0)
        dinner = self.new(date: start_date + i)
        dinner.e_type = "t_dinner"
        dinner.time = "6:00PM"
        dinner.value = (i<5)?1.5:3
        dinner.save
      end
    end
    return true
  end
  
end
