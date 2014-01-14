class Settings < ActiveRecord::Base
  
  def self.debug?
    return Settings.find("debug").val == 1
  end
  
end
