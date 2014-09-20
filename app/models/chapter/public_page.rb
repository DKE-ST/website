class Chapter::PublicPage < ActiveRecord::Base
  belongs_to :officer
  
  #Determines of logged in user has the ability to edit this page
  #@param user: instance of CurrentUser
  #@return boolean
  def can_edit(user)
    return false if user.nil?
    return false if user.brother.nil?
    return self.officer.dke_info.brother.id == user.brother.id
  end
end
