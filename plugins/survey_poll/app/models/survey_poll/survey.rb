class SurveyPoll::Survey < ActiveRecord::Base
  belongs_to :officer, class_name: "Chapter::Officer"
  has_many :questions
  #id  int(11)
  #title   varchar(255)
  validates :title, presence: true
  #description   text
  validates :descrption, presence: true
  #officer_id  int(11)
  validates :officer_id, presence: true
  #created_at  datetime
  #updated_at  datetime
  
  def resp_exists?(brother_id)
    return SurveyPoll::Response.exists?(brother_id: brother_id, question_id: self.question_ids)
  end
  
  def response_count
    return self.questions[0].responses.count
  end
  
  def responses
    results = Hash.new
    self.questions.order(position: :asc).each do | question |
      case question.qtype
      when /checkboxes/
        function = :disp_checkboxes
      when /grid/
        function = :disp_grid
      when /ranking/
        function = :disp_ranking
      else
        function = :disp_string
      end
      question.responses.each do | resp |
        response = send(function, resp)
        if results.include? resp.brother_id
          results[resp.brother_id] = results[resp.brother_id] + response
        else
          results[resp.brother_id] = response
        end
      end
    end
    return results
  end
  
  #methods for displaying results in human readable format
  def disp_checkboxes(resp)
    results = "<ul>".html_safe
    JSON.load(resp.response).each do | ans |
      results += "<li>".html_safe + "#{ans}" + "</li>".html_safe
    end
    results += "</ul>".html_safe
    return [results]
  end
  
  def disp_grid(resp)
    results = "".html_safe
    result_hash = JSON.load(resp.response)
    result_hash.each do | question, rating |
      results += "#{question}: #{rating}"
      results += "<br>".html_safe
    end
    return [results]
  end
  
  def disp_ranking(resp)
    results = "".html_safe
    result_hash = JSON.load(resp.response)
    result_hash.sort_by{|_key, value| value}.each do | element |
      results += "#{element[1]}: #{element[0]}"
      results += "<br>".html_safe
    end
    return [results]
  end
  
  def disp_string(resp)
    return [resp.response]
  end
end