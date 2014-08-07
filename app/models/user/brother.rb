class User::Brother < ActiveRecord::Base
  belongs_to :user
  has_one :mit_info
  has_one :dke_info
  #id  int(11)
  #user_id   int(11)
  #first_name  text
  #last_name   text
  #phone   varchar(10)
  #email   text
  #bio   text
  #activities  text
  #hobbies   text
  #pro_team  text
  #college_team  text
  #movie   text
  #quote   text
  #hometown  text
  #created_at  datetime
  #updated_at  datetime  
end
