class Chapter::Position < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  has_many :public_pages
end
