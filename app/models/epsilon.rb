class Epsilon < ActiveRecord::Base
  self.table_name = "e_sheets"
  #id: integer
  #date: date
  validates :date, format: {with: /\A20\d{2}-(0[1-9]|1[0-2])-([0-2]\d|3[01])\z/}
  #time: string
  validates :time, format: {with: /\A(0?[1-9]|1[0-2]):[0-5]\d(AM|PM)\z/}
  #e_type: string
  #uname: string
  #value: float
  validates :value, numericality: true
  #comment: text
  
  def self.new_week(start_date = Date.current+2)
    start_date -= start_date.days_to_week_start
    for dt in start_date..start_date+5
      return false if Epsilon.exists?(e_type: ["lunch","dinner"], date: dt)
    end
    for i in 0..5
      if i < 5
        for j in 0..2
          lunch = Epsilon.new(date: start_date + i)
          lunch.time = Settings.find("lunch_#{j}").val
          lunch.e_type = "lunch"
          lunch.value = Settings.find("dlunch_wkdy").val.to_f
          lunch.save
        end
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
  
  def self.get_week(date = Date.current+1)
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
    working = Epsilon.where("e_type != ?","entry")
    week = working.minimum("date")
    return meals if week.nil?
    week -= week.days_to_week_start
    max = working.maximum("date")
    while week < max
      meals << [week,Epsilon.get_week(week)]
      week += 7
    end
    meals.sort_by!{ |a| [max-a[0]]}
    return meals
  end
  
  def self.get_e_count
    needed = Settings.find("e_count").val.to_i
    day = Date.current + 1
    mon = day - day.days_to_week_start
    e_count = []
    Epsilon.meal_plan_list.each do | brother |
      tot = 0
      Epsilon.where("uname = ? AND date < ?", brother[1], mon).each do | e |
        puts e.value
        tot += e.value
      end
      rem = Settings.find("e_count").val.to_i - tot
      e_count << [brother[0], brother[1], tot, [rem,0].max]
    end
    return e_count
  end
  
  def self.get_others
    return Epsilon.where(e_type: "entry").order(:date)
  end
  
  def self.e_count
    return Settings.find("e_count").val.to_i
  end
  
  ########Getting users on meal plan ####################
  def self.get_on_meal_plan
    brothers = []
    BrothersDke.select("uname, p_class, meal_plan").where(meal_plan: 1).each do | bro |
      name = BrothersPersonal.find_by(uname: bro.uname).full_name
      brothers << {uname: bro.uname, name: name, p_class: bro.p_class}
    end
    brothers.sort_by!{ |a| [a[:p_class], a[:name]]}
    return brothers
  end
    
  def self.meal_plan_list
    brothers = Array.new([])
    BrothersDke.where(meal_plan: 1).each do | user |
    brother = BrothersPersonal.find_by(uname: user.uname)
      brothers << [brother.full_name, brother.uname]
    end
    brothers.sort!
    return brothers
  end
  
  def self.meal_plan_drop
    tmp = Epsilon.meal_plan_list
    tmp << ["",""]
    tmp.sort!
    return tmp
  end
  
  def self.get_off_meal_plan
    brothers = []
    BrothersDke.select("uname, p_class, meal_plan").where("meal_plan = 0 AND p_class < ?", 2014).each do | bro |
      brother = BrothersPersonal.find_by(uname: bro.uname)
      brothers << [brother.full_name, brother.uname]
    end
    brothers.sort!
    return brothers
  end
  
end
