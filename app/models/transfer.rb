class Transfer < ActiveRecord::Base
  #This class was used for the orginal transfer from the old database format
  establish_connection "site_old"
  
  def self.transfer_personal
    self.table_name = "brothers_personal"
    Transfer.select("*").each do | usr |
      x = User.new(uname: usr.uname, group: "dkebro")
      x.save
      attrs = usr.attributes
      attrs.delete("id")
      attrs.delete("uname")
      x.create_brother(attrs)
    end
  end
  
  def self.transfer_mit
    self.table_name = "brothers_mit"
    Transfer.select("*").each do | usr |
      x = User.find_by(uname: usr.uname)
      attrs = usr.attributes
      attrs.delete("id")
      attrs.delete("uname")
      x.brother.create_mit_info(attrs)
    end
  end
  
  def self.transfer_dke
    self.table_name = "brothers_dke"
    Transfer.select("*").each do | usr |
      x = User.find_by(uname: usr.uname)
      attrs = {p_name: usr.pname, project: usr.project, past_pos: usr.past_pos, p_class: usr.p_class}
      x.brother.create_dke_info(attrs)
      big = User.find_by(uname: usr.big)
      unless big.nil?
        x.brother.dke_info.big = big.brother.dke_info
        x.brother.dke_info.save
      end
    end
  end
end
