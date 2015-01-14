class Chapter::Officer < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  has_many :point_entries, class_name: "Chapter::HousePoint"
  has_many :public_pages
  #id  int(11)
  #name  varchar(255)
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  #title   text
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  #position  int(11)
  validates :position, presence: true
  #dke_info_id   int(11)
  #assign_points  tinyint(1) 
  #start_date  datetime 
  #disp  tinyint(1) 
  #contact   text
  #email   varchar(255)
  #created_at  datetime 
  #updated_at  datetime    
  
  #Override of original init method
  #@param params: dictionary of attributes
  #@param transfer: boolean, should only be true when used in Transfer model
  #@note: the purpose of this override is to automatically set position
  #@return boolean
  def initialize(params = {})
    super(params)
    position = Chapter::Officer.maximum("position")
    self.position = (position.nil?)?1:position + 1
  end
  
  #Override of valid? method to check that contact and disp are set correctly
  #@return boolean
  def valid?(params = {})
    if super(params)
      if self.disp && self.contact.blank?
        self.errors.add(:contact, "can't be blank and displayed")
        return false
      else
        return true
      end
    else
      return false
    end
  end
  
  ########################House Point Methods#########################
  
  def point_entry_breakdown
    officer_breakdown = Hash.new
    self.point_entries.each do | entry |
      year = entry.dke_info.brother.mit_info.year
      last_name = entry.dke_info.brother.last_name
      first_name = entry.dke_info.brother.first_name
      if officer_breakdown.include?({year: year, first: first_name, last: last_name})
        officer_breakdown[{year: year, first: first_name, last: last_name}] << entry
      else
        officer_breakdown[{year: year, first: first_name, last: last_name}] = [entry]
      end
    end
    return officer_breakdown.sort_by {|a, b| [a[:year], a[:last]]}
  end
  
  ##########################Static Methods############################
  
  #generates list of contact information based on the value of disp
  #@return Hash of selected officers
  def self.contact_info
    officers = Hash.new
    position_map =  self.where(disp: 1).order(:position)
    position_map.each do |pos|
      if pos.dke_info
        name = pos.dke_info.brother.full_name
        year = pos.dke_info.brother.mit_info.year.to_s[2..3]
        if pos.email.blank?
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
  
  #generates a list of all officers for the index page
  #@return Hash of officers
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
  
  #method to update all officers after elections
  #@param params: dictionary of officers and holders ( {officer.id: brother.dke_info.id})
  def self.mass_update(params)
    params.each do | id, dke_info_id |
      self.find(id).update_attributes({dke_info_id: dke_info_id})
    end
  end
  
  #updates ordering on index and contact pages & disp parameter
  #@param params: dictionary of officers and position ({officer.id: {disp: disp, position: position}})
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
  
end
