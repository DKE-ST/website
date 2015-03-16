class SurveyPoll::ResultsController < AuthenticationController
  
  def index
    @surveys = SurveyPoll::Survey.where(officer_id: @me.positions.ids)
  end
  
  def show
    @survey = SurveyPoll::Survey.find(params[:id])
    @results = {};
    @survey.questions.order(position: :asc).each do | question |
      question.responses.each do | resp |
        if @results.include? resp.brother_id
          @results[resp.brother_id] << resp
        else
          @results[resp.brother_id] = [resp]
        end
      end
    end
  end
  
end
