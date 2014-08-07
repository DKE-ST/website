class User::Brother::DkeInfo < ActiveRecord::Base
  belongs_to :brother
  belongs_to :big, class_name: "User::Brother::DkeInfo"
  has_many :littles, class_name: "User::Brother::DkeInfo", foreign_key: "big_id"
  #belongs_to :residence
end
