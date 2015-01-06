class Calendar::Event < ActiveRecord::Base
  #id  int(11)
  #title   varchar(255)
  #desc  text
  #officer_id  int(11)
  #start   datetime
  #end   datetime
  #created_at  datetime
  #updated_at  datetime
  
  def self.get_events(params = {})
    start_time = (params.include? :start)?Date.parse(params[:start]):0
    end_time = (params.include? :end)?Date.parse(params[:end]):Float::INFINITY
    events = []
    
    return events
  end
  
end
