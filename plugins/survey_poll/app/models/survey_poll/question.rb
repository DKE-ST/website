class SurveyPoll::Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  #id  int(11)
  #question  text
  validates :question, presence: true
  #position  int(11)
  validates :position, presence: true
  #survey_id   int(11)
  validates :survey_id, presence: true
  #qtype   varchar(255)
  validates :qtype, presence: true, format: {with: /mc|checkboxes|ranking|grid|scale|numerical|text|paragraph/}#|date|time/}
  #option  text
  #option#text
  #created_at  datetime
  #updated_at  datetime
  
end