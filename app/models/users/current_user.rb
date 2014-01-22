class CurrentUser
  attr_accessor :uname
  
  def initialize(uname)
    self.uname = uname
  end
  
  def in_group(group_name)
    return false unless self.uname
    return true if Settings.debug? && Apache.groups(self.uname).include?("brochicken")
    return Apache.groups(self.uname).include? group_name
  end
  
  def is?(position)
    return true if Settings.debug? && Apache.groups(self.uname).include?("brochicken")
    return Positions.exists?(uname: self.uname, position: position)==1
  end
  
  def positions
    point_pos = ["beta", "sigma", "zeta", "epsilon", "delta", "gamma"]
    pos_list = Positions.where(position: point_pos)
    return pos_list if adm_acess?
    return pos_list.where(uname: self.uname)
  end
  
  def brother?
    return in_group("dkebro")
  end
  
  def pledge?
    return in_group("dkepledge") ||  in_group("dkebro")
  end
  
  def pwd?
    return true if adm_acess?
    File.open("#{Apache.dke_path}/dke_users.passwd").each_line do |line|
      return true if line.include?(self.uname) && self.uname != 'dkealum'
    end
    return false
  end
  
  def adm_acess?
    Settings.debug? && self.in_group("brochicken")
  end
    
end