class SurveyPoll::Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :brother, class_name: "User::Brother"
  #id  int(11)
  #question_id   int(11)
  #brother_id  int(11)
  #response  text
  #created_at  datetime
  #updated_at  datetime
end
