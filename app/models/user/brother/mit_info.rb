class User::Brother::MitInfo < ActiveRecord::Base
  belongs_to :brother
  #id  int(11)
  #brother_id  int(11)
  #majors  text
  #minors  text
  #concentration   text
  #extracurriculars  text
  #interests   text
  #urops   text
  #internships   text
  #fav_classes   text
  #year  int(4)
  validates :year, presence: true, format: {with: /[\d]{4}/}
  #created_at  datetime
  #updated_at  datetime  
end
