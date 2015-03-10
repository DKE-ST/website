class SurveyPoll::Survey < ActiveRecord::Base
  belongs_to :officer, class_name: "Chapter::Officer"
  has_many :questions
  #id  int(11)
  #title   varchar(255)
  validates :title, presence: true
  #description   text
  validates :descrption, presence: true
  #officer_id  int(11)
  validates :officer_id, presence: true
  #created_at  datetime
  #updated_at  datetime
end
