class HousePoints::Entry < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother:DkeInfo"
  belongs_to :officer, class_name: "Chapter::Officer"
  #id  int(11)
  #dke_info_id   int(11)
  #officer_id  int(11)
  #value   float
  #comment   varchar(255)
  #date  date
end