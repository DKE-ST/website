class SurveyPoll::Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :brother, class_name: "User::Brother"
  #id  int(11)
  #question_id   int(11)
  #brother_id  int(11)
  #response  text
  #created_at  datetime
  #updated_at  datetime
  
  def initialize(params = nil)
    super
    unless params.nil?
      case self.question.qtype
      when /checkbox/
        self.response = JSON.dump(params[:response].keys)
      when /grid|ranking/
        self.response = JSON.dump(params[:response])
      end
    end
  end
end
