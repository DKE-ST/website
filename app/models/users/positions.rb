class Positions < ActiveRecord::Base
  validates :uname, length: { maximum: 8 }
  validates :position, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  def initialize(position, name, uname=nil, start_date=Date.today)
    super()
    self.position = position
    self.name = name
    if uname
      self.uname = uname
      self.start_date = start_date
    end
    self.save
  end
  
  def self.update_position(position, uname)
    pos = Positions.find_by(position: position)
    pos.uname = uname
    if pos.uname_changed?
      BrothersDke.add_past_pos(pos.uname_was, position, pos.start_date, Date.today)
      #pos.start_date = Date.today
      #pos.save
    end
  end
  
  def self.get_current(uname)
    res = []
    Positions.where(uname: uname).each do |pos|
      res << pos.name
    end
    return res.join(", ")
  end
end
