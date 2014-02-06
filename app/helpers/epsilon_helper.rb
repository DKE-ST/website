module EpsilonHelper
  
  def get_meal_time(e_type, date)
    if e_type =~ /lunch/
      key = (date.wday<6)?e_type:"lunch_wknd"
      type = "Lunch"
    elsif e_type =~ /dinner/
      key = (date.wday<6)?"dinner_wkdy":"dinner_wknd"
      type = "Dinner" 
    else
      raise "Unknown meal type"
    end
    time = Settings.find(key).val
    return "#{time} #{type}: "
  end
  
  def get_server(server, e_type, date)
    key = (date.wday<6)?e_type:"lunch_wknd" if e_type =~ /lunch/
    key = (date.wday<6)?"dinner_wkdy":"dinner_wknd" if e_type =~ /dinner/
    time = Time.now + 300 < Time.parse(Settings.find(key).val, date)
    if server.empty?
      return "Meal Missed" unless time
      return button_tag("Sign Up" , name: "meal[sign_up]" , value: e_type)
    else 
      name = BrothersPersonal.find_by(uname: server).full_name
      return name unless time && server == @me.uname
      drop = button_tag("Drop" , name: "meal[drop]" , value: e_type)
      return "#{name} #{drop}".html_safe
    end
  end
  
end
