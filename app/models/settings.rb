class Settings < ActiveRecord::Base
  
  def self.debug?
    return Settings.find("debug").val.to_i == 1
  end
  
  def self.mode?(num)
    return Settings.find("server").val.to_i == num
  end
  
end
