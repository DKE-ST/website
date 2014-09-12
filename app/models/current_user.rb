class CurrentUser < User
  
  #Override method for find_by
  #This is used so we have an instance for website visitors who aren't logged in
  def CurrentUser.find_by(params)
    user = super(params)
    return CurrentUser.new if user.nil?
    return user
  end
  
  #Returns bool whether the current user is logged in
  def valid_user?
    return !self.uname.nil?
  end
  
  #Returns bool whether brother_id matches id
  def is_brother?(id)
    return true if self.admin?("broporn")
    return false if self.brother.nil?
    return self.brother.id.to_s == id.to_s
  end
  
  #Returns whether user meets admin group requirement
  def admin?(level)
    return false if self.chicken.blank?
    list = ["broweb", "broporn", "brochicken"]
    return list.index(self.chicken) >= list.index(level)
  end
  
  #Returns whether user meets group requirement
  def group?(group)
    return false if self.group.nil?
    if ['dkeactive', 'dkealum'].include? self.group
      dke_group = 'dkebro'
    else
      dke_group = self.group
    end
    list = ["dkeaffil", "dkepledge", "dkebro"]
    return list.index(dke_group) >= list.index(group)
  end
  
end
