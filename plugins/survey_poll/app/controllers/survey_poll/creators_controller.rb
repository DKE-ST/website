class SurveyPoll::CreatorsController < ApplicationController
  
  def index
    @surveys = SurveyPoll::Survey.where(officer_id: @me.positions.ids)
  end
  
  
  
end
