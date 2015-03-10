class SurveyPoll::Question::Scale < SurveyPoll::Question
  validates :option, presence: true, numericality: true
  validates :option2, presence: true, numericality: true
end
