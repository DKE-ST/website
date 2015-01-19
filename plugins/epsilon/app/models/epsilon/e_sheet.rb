class Epsilon::ESheet < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  #id  int(11)
  #dke_info_id   int(11)
  validates :dke_info_id, presence: {message: "-- Server can't be blank"}, if: "e_type == 'entry'"
  #date  date
  validates :date, format: {with: /\A20\d{2}-(0[1-9]|1[0-2])-([0-2]\d|3[01])\z/}, unless: "e_type =~ /t_.*|total/"
  #time  time
  validates :time, format: {with: /\A(0?[1-9]|1[0-2]):[0-5]\d(AM|PM)\z/}, if: "e_type != 'entry'"
  #e_type  varchar(8)
  validates :e_type, presence: true
  #value   float
  validates :value, presence: true, numericality: true
  #comment   text
  validates :comment, presence: true, if: "e_type == 'entry'"
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
  
  def self.get_all_meals
    meals = []
    working = self.where(e_type: ["lunch","dinner"])
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
  
  def self.get_others
    return self.where(e_type: "entry").order(:date)
  end
  
  def self.e_count
    return self.find_by(e_type: "total").value
  end
  
  def self.update_e_count(value)
    e_count = self.find_by(e_type: "total")
    e_count.value = value
    if e_count.valid?
      e_count.save
      return true
    else
      return false
    end
  end
  
  def self.delays
    return [-900,300]
  end
  
  def self.destroy_all
    self.connection.execute("TRUNCATE #{self.table_name}")
  end
  
  def self.sign_up(params, user)
    meal = self.find(params[:id])
    if params[:action]=="add"
      if Time.now + self.delays[0] > Time.parse(meal.time, meal.date)
        return [false, "It is too late to sign up to serve this meal.  Please Contact the Epsilon"]
      elsif meal.dke_info.nil?
        meal.dke_info_id = user.brother.dke_info.id
        meal.save
        return [true, nil]
      elsif meal.dke_info.brother_id == user.brother.id
        return [false, "You already signed up to serve this meal"]
      else
        return [false, "Another brother has already signed up"]
      end
   else
      if Time.now + self.delays[1] > Time.parse(meal.time, meal.date)
        return [false, "It is too late to unsign up to serve this meal.  Please Contact the Epsilon"]
      elsif meal.dke_info.nil?
        return [false, "No one is signed up for this meal"]
      elsif meal.dke_info.brother_id != user.brother.id
        return [false, "You cannot unsign up another brother"]
      else
        meal.dke_info_id = nil
        meal.save
        return [true, nil]
      end   
    end
  end
  
  def self.track_progress
    needed = self.e_count
    day = Date.current + 1
    mon = day - day.days_to_week_start
    e_count = []
    User::Brother::DkeInfo.list({"meal_plan" => true}).each do | brother |
      tot = 0
      self.where("dke_info_id = ? AND date < ?", brother[:id], mon).each do | e |
        puts e.value
        tot += e.value
      end
      rem = needed - tot
      e_count << [brother[:first_name], brother[:last_name], tot, [rem,0].max]
    end
    e_count.sort_by!{ |a| [a[2], a[1], a[0]]}
    return e_count
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
    unless self.exists?(e_type: "total")
      self.new(time: "12:00AM", value: 16, e_type: "total").save
    end
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
    #TODO: Add Total element
    return true
  end
  
end
