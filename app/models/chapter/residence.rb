class Chapter::Residence < ActiveRecord::Base
  has_many :occupants, class_name: "User::Brother::DkeInfo"
  #id  int(11)
  #name  varchar(255)
  #floor   int(1)
  #capacity  int(1)
  #created_at  datetime
  #updated_at  datetime
  
  def update_attributes(params)
    return false unless super(residence_params(params))
    soft_params = params.require(:chapter_residence)
    if soft_params.include? "picture"
      return false unless self.upload_picture(soft_params)
    end
    if soft_params.include? "occupants"
      occ = []
      soft_params[:occupants].each do | no, id |
        occ << id if no.to_i < self.capacity && id != "null"
      end
      self.occupant_ids = occ
    end
    return true
  end
  
  def occupant_names
    out = []
    self.occupants.each do | occupant |
      out << occupant.brother.full_name
    end
    return out.join(", ")
  end
  
  def pic_path(root_path, write = false)
    path =  "#{root_path}assets/house_img/#{self.id}.jpg"
    if File.exists?("public#{path}") || write
      return path
    else
      return path
    end
  end
  
  def upload_picture(params)
    uploaded_io=params[:picture]
    if uploaded_io.content_type =~ /image/
      File.open(pic_path(Rails.root.join("public/").to_s, true), "wb") do |file|
        file.write(uploaded_io.read)
      end
      return true
    end
    return false
  end
  
  def self.room_picks(params)
    params.require(:chapter_residence).each do | room_no, occupants |
      if self.exists?(room_no)
        room = self.find(room_no)
        occ = []
        occupants.each do | no, id |
          occ << id if no.to_i < room.capacity && id != "null"
        end
        room.occupant_ids = occ
      end
    end
    return true
  end
  
  def self.list_all(where = nil)
    out = Hash.new
    if where
      rooms = self.where(where)
    else
      rooms = self.select("*")
    end
    rooms.order("floor").each do | room |
      key = ((room.floor > 0)?"Floor #{room.floor}":"Dorms")
      capacity = ((room.capacity >= 0)?"#{room.capacity}":"N/A")
      out[key] = Array.new([]) if !out.include? key
      out[key] << {id: room.id,
                   name: room.name,
                   capacity: capacity,
                   occupants: room.occupant_names,
                   occupants_ids: room.occupant_ids}
    end
    return out
  end
  
 private
 
  def residence_params(params)
    params.require(:chapter_residence).permit(:name, :floor, :capacity)
  end
end
