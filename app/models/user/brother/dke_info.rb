class User::Brother::DkeInfo < ActiveRecord::Base
  belongs_to :brother
  belongs_to :big, class_name: "User::Brother::DkeInfo"
  has_many :littles, class_name: "User::Brother::DkeInfo", foreign_key: "big_id"
  belongs_to :residence, class_name: "Chapter::Residence"
  has_many :positions, class_name: "Chapter::Position"
  
  def initialize(params = {})
    littles = params.delete(:little_ids)
    super(params)
    assign_littles(littles)
  end
  
  def update_attributes(params)
    assign_littles(params.delete(:little_ids))
    return super(params)
  end
  
  def assign_littles(little_array)
    if little_array
      littles = []
      little_array.split(",").each do | element |
        littles << element.to_i unless element == "null"
      end
      self.little_ids = littles
    end
  end
end
