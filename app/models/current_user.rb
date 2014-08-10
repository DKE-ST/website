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
  
  #Returns whether user meets group requirement
  def group?(group)
    return false if self.group.nil?
    list = ["dkeaffil", "dkepledge", "dkebro"]
    return list.index(self.group) >= list.index(group)
  end
  
end
