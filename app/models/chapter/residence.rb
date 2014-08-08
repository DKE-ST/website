class Chapter::Residence < ActiveRecord::Base
  has_many :occupants, class_name: "User::Brother::DkeInfo"
end
