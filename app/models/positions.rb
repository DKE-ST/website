class Positions < ActiveRecord::Base
  validates :uname, length: { maximum: 8 }
  validates :position, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  def initialize(params = {})
    super(params)
    self.start_date = Date.today
  end
  
  def self.update_position(position, uname)
    pos = Positions.find_by(position: position)
    pos.uname = uname
    if pos.uname_changed?
      BrothersDke.add_past_pos(pos.uname_was, pos.name, pos.start_date, Date.today)
      pos.start_date = Date.today
      pos.save
    end
  end
  
  def self.get_current(uname)
    res = []
    Positions.where(uname: uname).each do |pos|
      res << pos.name
    end
    return res.join(", ")
  end
  
  def self.positions_awarding
    positions = []
    Positions.where(award_points: 1).each do | pos |
      positions << pos.position
    end
    return positions
  end
end
