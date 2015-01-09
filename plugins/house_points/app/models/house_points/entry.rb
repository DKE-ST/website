class HousePoints::Entry < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother:DkeInfo"
  belongs_to :officer, class_name: "Chapter::Officer"
  #id  int(11)
  #dke_info_id   int(11)
  validates :dke_info_id, presence: true
  #officer_id  int(11)
  validates :officer_id, presence: true
  #value   float
  validates :value, presence: true
  #comment   varchar(255)
  validates :comment, presence: true
  #date  date
  
  
end