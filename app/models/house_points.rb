class HousePoints < ActiveRecord::Base
  
  #id: integer
  #uname: string
  #position: text
  #value: integer
  #comment: text
  #start_date: date
  
  def self.get_points(uname)
    return HousePoints.where(uname: uname)
  end
  
  def self.get_pos_points(uname, position)
    return HousePoints.get_points(uname).where(position: position)
  end
  
  def self.get_point_breakdown(uname)
    points = {}
    Positions.exec_positions.each do | pos |
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
