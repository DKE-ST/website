class User::Brother::DkeInfo < ActiveRecord::Base
  belongs_to :brother
  belongs_to :big, class_name: "User::Brother::DkeInfo"
  has_many :littles, class_name: "User::Brother::DkeInfo", foreign_key: "big_id"
  belongs_to :residence, class_name: "Chapter::Residence"
  has_many :positions, class_name: "Chapter::Position"
  
  def update_attributes(params)
    if params[:little_id]
      little_ids = params.delete(:little_id).split(",")
      little_ids.each do | little |
        unless little == "null"
          brother = User::Brother::DkeInfo.find(little)
          if brother.big_id != self.id
            brother.big_id = self.id
            brother.save
          end
        end
      end
      self.littles.each do | little |
        if little_ids.find_index(little.id.to_s).nil?
          little.big_id = nil
          little.save
        end
      end
    end
    return super(params)
  end
end
