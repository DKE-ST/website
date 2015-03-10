class SurveyPoll::SurveysController < AuthenticationController
  
  def index
    @surveys = SurveyPoll::Survey.select("*")
  end
  
  def show
    @survey = SurveyPoll::Survey.find(params[:id])
  end
end
