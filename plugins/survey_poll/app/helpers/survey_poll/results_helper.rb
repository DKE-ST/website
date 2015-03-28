module SurveyPoll
  module ResultsHelper
    
    def get_rid(bid, sid)
      qids = SurveyPoll::Question.where(survey_id: sid).ids
      rid = SurveyPoll::Response.where(brother_id: bid, question_id: qids).ids[0]
      out = link_to @i, main_app.result_user_path(sid, rid)
      @i += 1
      return out
    end
    
    def get_year(bid)
      return User::Brother.find(bid).mit_info.year
    end
    
  end
end
