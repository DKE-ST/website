class SurveyPoll::ResultsController < AuthenticationController
  
  def index
    @surveys = SurveyPoll::Survey.where(officer_id: @me.positions.ids)
  end
  
  def show
    @survey = SurveyPoll::Survey.find(params[:id])
    @i=1
  end
  
  def show_user
    @survey = SurveyPoll::Survey.find(params[:id])
    @brother = SurveyPoll::Response.find(params[:uid]).brother
    @responses = @survey.responses[@brother.id]
  end
  
end
