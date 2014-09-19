class Chapter::Officer < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  has_many :public_pages
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  
  def valid?(params)
    if super(params)
      if self.disp && self.contact.empty?
        self.errors.add(:contact, "can't be blank and displayed")
        return false
      else
        return true
      end
    else
      return false
    end
  end
  
  def self.update_contacts(params)
    params.each do | id, fields |
      if id =~ /\A\d+\z/
        unless self.find(id).update_attributes(params.require(id).permit(:disp, :position))
          return false
        end
      end
    end
    return true
  end
  
  def self.list_all
    officers = []
    position_map =  self.select("id, position, name, dke_info_id, contact, disp, title").order(:position)
    position_map.each do | pos |
      begin
        name = pos.dke_info.brother.full_name
        year = pos.dke_info.brother.mit_info.year.to_s[2..3]
      rescue
        name = ""
        year = ""
      end
      officers << {id: pos.id,
                   name: pos.name,
                   title: pos.title,
                   full_name: name,
                   year: year,
                   pos: pos.position, 
                   disp: pos.disp,
                   contact: pos.contact}
    end
    return officers
  end
  
  def self.contact_info
    officers = Hash.new
    position_map =  self.where(disp: 1).order(:position)
    position_map.each do |pos|
      if pos.dke_info
        name = pos.dke_info.brother.full_name
        year = pos.dke_info.brother.mit_info.year.to_s[2..3]
        if pos.email.nil?
          email = "#{pos.dke_info.brother.user.uname}@mit.edu"
        else
          email = pos.email
        end
        officers[pos.name] = {name: pos.title, 
                                  full_name: name, 
                                  year: year, 
                                  contact: pos.contact, 
                                  email: email}
      end
    end
    return officers
  end
  
end
