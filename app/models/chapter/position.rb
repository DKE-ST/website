class Chapter::Position < ActiveRecord::Base
  belongs_to :dke_info, class_name: "User::Brother::DkeInfo"
  has_many :public_pages
  
  def self.contact_info
    officers = Hash.new
    position_map =  Chapter::Position.select("*")
    position_map.each do |pos|
      if pos.disp && pos.dke_info
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
