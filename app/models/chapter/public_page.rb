class Chapter::PublicPage < ActiveRecord::Base
  belongs_to :position
  
  def can_edit(user)
    return false if user.nil?
    return false if user.brother.nil?
    return self.position.dke_info.brother.id == user.brother.id
  end
end
