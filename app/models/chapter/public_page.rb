class Chapter::PublicPage < ActiveRecord::Base
  belongs_to :officer
  
  #id  int(11)
  #pname   varchar(255)
  validates :pname, presence: true, uniqueness: true
  #officer_id  int(11)
  #title   varchar(255)
  validates :title, presence: true
  #content   text
  validates :content, presence: true
  #created_at  datetime
  #updated_at  datetime
  
  #Determines of logged in user has the ability to edit this page
  #@param user: instance of CurrentUser
  #@return boolean
  def can_edit(user)
    return false if user.nil?
    return false if user.brother.nil?
    return self.officer.dke_info.brother.id == user.brother.id
  end
end
