module Epsilon
  class ESheet < ActiveRecord::Base
    #id  int(11)
    #dke_info_id   int(11)
    #date  date
    validates :date, format: {with: /\A20\d{2}-(0[1-9]|1[0-2])-([0-2]\d|3[01])\z/}
    #time  time
    validates :time, format: {with: /\A(0?[1-9]|1[0-2]):[0-5]\d(AM|PM)\z/}
    #e_type  varchar(8)
    validates :e_type, presence: true
    #value   float
    validates :value, presence: true, numericality: true
    #comment   text
    #created_at  datetime
    #updated_at  datetime 
  end
  
  
end
