class Settings < ActiveRecord::Base
  
  def self.debug?
    return Settings.find("debug").val == 1
  end
  
  def self.mode?(num)
    return Settings.find("server").val == num
  end
  
end
