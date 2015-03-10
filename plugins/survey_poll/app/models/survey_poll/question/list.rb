class SurveyPoll::Question::List < SurveyPoll::Question
  validates :option, presence: true
  validates :option2, absence: true
end
