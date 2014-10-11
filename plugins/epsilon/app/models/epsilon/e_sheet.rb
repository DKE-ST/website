module Epsilon
  class ESheet < ActiveRecord::Base
    #id  int(11)
    #dke_info_id   int(11)
    #date  date
    #time  time
    #e_type  varchar(8)
    validates :e_type, presence: true
    #value   float
    validates :value, presence: true
    #comment   text
    #created_at  datetime
    #updated_at  datetime 
  end
  
  
end
