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
  
  #Method to return brother index information by year
  def self.get_indexes
    brothers = Hash.new
    class_map = User::Brother::MitInfo.select("year, brother_id").order("year DESC")
    class_map.each do | bro |
      brothers[bro.year] = Array.new([]) if !brothers.include? bro.year
      brothers[bro.year] << [bro.brother.full_name, bro.brother_id]
    end
    brothers.each do |key, value|
      value.sort!
    end
    return brothers
  end
  
  #Returns full name from brother information
  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
  
  def pic_path(root_path)
    return "#{root_path}assets/brothers_img/#{self.first_name.downcase}_#{self.last_name.downcase}.jpg"
  end
end
