class User::Brother::DkeInfo < ActiveRecord::Base
  belongs_to :brother
  belongs_to :big, class_name: "User::Brother::DkeInfo"
  has_many :littles, class_name: "User::Brother::DkeInfo", foreign_key: "big_id"
  belongs_to :residence, class_name: "Chapter::Residence"
  has_many :positions, class_name: "Chapter::Officer"
  #id  int(11)
  #brother_id  int(11)
  #p_name  text
  #project   text
  #past_pos  text
  #big_id  int(11)
  #residence_id  int(11)
  #p_class   int(4)
  validates :p_class, presence: true, format: {with: /[\d]{4}/}
  #created_at  datetime
  #updated_at  datetime
  
  #override of init method to call assign_littles function
  def initialize(params = {})
    littles = params.delete(:little_ids)
    super(params)
    assign_littles(littles)
  end
  
  #override of update_attributes method to call assign_littles function
  def update_attributes(params)
    assign_littles(params.delete(:little_ids))
    return super(params)
  end
  
  #Takes list of little borther ids and removes and not valid ids before assigning 
  # them to self.little_ids
  def assign_littles(little_array)
    if little_array
      littles = []
      little_array.split(",").each do | element |
        littles << element.to_i unless element == "null" || element == "new"
      end
      self.little_ids = littles
    end
  end
  
  #################Static Methods####################
  
  #Returns the year for the current pledge class
  #@return integer
  def self.cur_p_class
    return Date.current.year + 3 + ((Date.current.month > 7)?1:0)
  end
end
