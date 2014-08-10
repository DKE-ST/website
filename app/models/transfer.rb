class Transfer < ActiveRecord::Base
  #This class was used for the orginal transfer from the old database format
  establish_connection "site_old"
  
  def self.transfer_all
    Transfer.personal
    Transfer.mit
    Transfer.dke
    Transfer.positions
    Transfer.residence
    Transfer.public_pages
  end
  
  def self.personal
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
  
  def self.mit
    self.table_name = "brothers_mit"
    Transfer.select("*").each do | usr |
      x = User.find_by(uname: usr.uname)
      attrs = usr.attributes
      attrs.delete("id")
      attrs.delete("uname")
      x.brother.create_mit_info(attrs)
    end
  end
  
  def self.dke
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
  
  def self.positions
    self.table_name = "positions"
    Transfer.select("*").each do | pos |
      attrs = {name: pos.position, title: pos.name, start_date: pos.start_date, contact: pos.contact, disp: pos.disp}
      position = Chapter::Position.new(attrs)
      brother = User.find_by(uname: pos.uname).brother.dke_info
      position.dke_info = brother
      position.save
    end
  end
  
  def self.residence
    self.table_name = "house_rooms"
    Transfer.select("*").each do | rooms |
      attrs = {name: rooms.name, capacity: rooms.capacity, floor: rooms.floor}
      rm = Chapter::Residence.new(attrs)
      rm.save
      for i in 0..4
        bro = User.find_by(uname: rooms["occupant#{i}"])
        unless bro.nil?
          dke_info = bro.brother.dke_info
          dke_info.residence = rm
          dke_info.save
        end
      end
    end
  end
  
  def self.public_pages
    self.table_name = "chapter_public"
    Transfer.select("*").each do | pg |
      attrs = {pname: pg.pname, title: pg.title, content: pg.content}
      page = Chapter::PublicPage.new(attrs)
      if pg.user != "broporn"
        page.position = Chapter::Position.find_by(name: pg.user)
      else
        page.position = Chapter::Position.find_by(name: "broweb")
      end
      page.save
    end
  end
end
