class HousePoints < ActiveRecord::Base
  
  def self.new_semester(year = Date.today.year)
    #TODO Inset code to store past house point tables???
    HousePoints.destroy_all
    BrothersMit.where("year > ?", year).order(year: :desc).each do |brother|
      HousePoints.new({uname: brother.uname}).save
    end
  end
  
  def total
    tot = 100
    self.attribute_names.each do |type|
      tot -= self[type] unless type=="uname"
    end
  return tot
  end
  
end
