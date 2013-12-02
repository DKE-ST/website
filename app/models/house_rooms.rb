class HouseRooms < ActiveRecord::Base
  self.table_name = "house_rooms"
  validates :id, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 3 }
  validates :floor, presence: true
  validates :name, presence: true
  validates :capacity, presence: true
  validates :occupant0, presence: true
end
