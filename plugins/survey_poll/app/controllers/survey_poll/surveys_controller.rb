class SurveyPoll::SurveysController < AuthenticationController
  
  def index
    @surveys = SurveyPoll::Survey.select("*")
  end
  
  def show
    @survey = SurveyPoll::Survey.find(params[:id])
  end
  
  def update
    @survey = SurveyPoll::Survey.find(params[:id])
    if @survey.resp_exists?(@me.brother.id)
      flash[:error] = "You have already filled out this survey."
    else
      responses = params.require(:questions)
      responses.keys.each do | qid |
        if @survey.question_ids.include? qid.to_i
          SurveyPoll::Response.new(question_id: qid.to_i, brother_id: @me.brother.id, response: responses[qid]).save
        end
      end
      flash[:success] = "Thank you!  Your responses have been recorded."
    end
    redirect_to main_app.root_path
  end
end
