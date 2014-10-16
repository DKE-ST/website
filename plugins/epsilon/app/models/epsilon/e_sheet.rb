module Epsilon
  class ESheet < ActiveRecord::Base
    #id  int(11)
    #dke_info_id   int(11)
    #date  date
    #time  time
    #e_type  varchar(8)
    validates :e_type, presence: true
    #value   float
    validates :value, presence: true, numericality: true
    #comment   text
    #created_at  datetime
    #updated_at  datetime
    
    def self.weekly_schedule
      date = Date.new(0,1,5)
      meals = {}
      for i in 0..5
        day = (date+i)
        meals[day] = self.where(date: date+i)
      end
      return meals
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
    
    def self.list_meals(type = nil)
      meals = []
      working = self.where("e_type = ? OR e_type=?","lunch", "dinner")
      working = working.where(comment: type) unless type.nil?
      week = working.minimum("date")
      return meals if week.nil?
      week -= week.days_to_week_start
      max = working.maximum("date")
      while week < max
        meals << [week,self.get_week(week)]
        week += 7
      end
      meals.sort_by!{ |a| [max-a[0]]}
      return meals
    end
    
    def self.new_week(start_date = Date.new(0,1,5))
      for i in 0..5
        if i < 5
          for j in 0..2
            lunch = Epsilon::ESheet.new(date: (start_date + i))
            lunch.time = ["11:30AM","12:15PM","1:15PM"][j]
            lunch.e_type = "t_lunch"
            lunch.value = 1
            lunch.save
          end
        end
        for j in 0..((i<5)?1:0)
          dinner = Epsilon::ESheet.new(date: start_date + i)
          dinner.e_type = "t_dinner"
          dinner.time = "6:00PM"
          dinner.value = 1.5
          dinner.save
        end
      end
      return true
    end
    
  end
end
