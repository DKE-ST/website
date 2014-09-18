class Chapter::PublicPage < ActiveRecord::Base
  belongs_to :officer
  
  def can_edit(user)
    return false if user.nil?
    return false if user.brother.nil?
    return self.officer.dke_info.brother.id == user.brother.id
  end
end
