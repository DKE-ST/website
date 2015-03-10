class SurveyPoll::Question::Grid < SurveyPoll::Question
  validates :option, presence: true
  validates :option2, presence: true
end
