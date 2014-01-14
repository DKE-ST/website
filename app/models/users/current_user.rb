class CurrentUser
  attr_accessor :uname
  
  def initialize(uname)
    self.uname = uname
  end
  
  def in_group(group_name)
    return false unless self.uname
    return true if Apache.groups(self.uname).include? "brochicken"
    return Apache.groups(self.uname).include? group_name
  end
  
  def positions
    point_pos = ["beta", "sigma", "zeta", "epsilon", "delta", "gamma"]
    pos_list = Positions.where(position: point_pos)
    return pos_list if self.in_group("brochicken")
    return pos_list.where(uname: self.uname)
  end
  
  def brother?
    return in_group("dkebro")
  end
  
  def pledge?
    return in_group("dkepledge")
  end
  
  def pwd?
    File.open("#{Apache.dke_path}/dke_users.passwd").each_line do |line|
      return true if line.include? self.uname
    end
    return false
  end
end