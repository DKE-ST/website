class HousePoints < ActiveRecord::Base
  
  #id: integer
  #uname: string
  #position: text
  #value: integer
  #comment: text
  #date: date
  
  validates :uname, length: { maximum: 8 }
  validates :value, presence: true
  validates :comment, presence: true
  
  def self.get_active
    brothers = HousePoints.in_house
    BrothersMit.select("uname, year").each do | brother |
      if brother.year >= Date.current.year + ((Date.current.month > 6)?1:0)
        brothers << brother.uname unless brothers.index(brother.uname)
      end
    end
    return brothers
  end
  
  def self.in_house
    brothers = []
    HouseRooms.select("*").each do | room |
      for i in 0..3
        brothers << room["occupant#{i}"] unless room["occupant#{i}"].empty?
      end
    end
    return brothers
  end
  
  def self.get_points(uname)
    return HousePoints.where(uname: uname)
  end
  
  def self.get_pos_points(uname, position)
    return HousePoints.get_points(uname).where(position: position)
  end
  
  def self.get_point_breakdown(uname)
    points = {}
    Positions.positions_awarding.each do | pos |
      points[pos] = {val: 0, full: []}
    end
    HousePoints.get_points(uname).each do | point_given |
      points[point_given.position][:val] += point_given.value
      points[point_given.position][:full] << point_given
    end
    tot = 0
    points.each do | key , val |
      tot += val[:val]
    end
    return points
  end
  
  def self.total_points(uname)
    total = 0
    HousePoints.get_points(uname).each do | point_given |
      total += point_given.value
    end
    return total
  end
  
end
