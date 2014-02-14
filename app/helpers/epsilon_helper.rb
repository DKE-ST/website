module EpsilonHelper
  
  def get_serv(server, time, date)
    if server.empty?
      time = Time.now - 900 < Time.parse(time, date)
      return "Meal Missed" unless time
    else 
      return BrothersPersonal.find_by(uname: server).full_name
    end
  end
  
  def get_server(server, time, date)
    if server.empty?
      time = Time.now - 900 < Time.parse(time, date)
      return "Meal Missed" unless time
      return button_tag("Sign Up" , name: "meal[action]" , value: "add")
    else 
      time = Time.now + 300 < Time.parse(time, date)
      name = BrothersPersonal.find_by(uname: server).full_name
      return name unless time && server == @me.uname
      drop = button_tag("Drop" , name: "meal[action]" , value: "drop")
      return "#{name} #{drop}".html_safe
    end
  end
  
  def disp_other(entry, path)
    name = BrothersPersonal.find_by(uname: entry.uname).full_name
    main = link_to "#{name} :: #{entry.value}" , "#{path}/#{entry.id}"
    cmt = "&nbsp;&nbsp;-- #{entry.comment}"
    return "#{main}<br>#{cmt}".html_safe
  end
  
  def disp_meal(meal)
    pt1 = "#{meal.e_type.humanize} #{meal.time} ::"
    key = (meal.date.wday<6)?(meal.e_type):"lunch_wknd" if meal.e_type =~ /lunch/
    key = (meal.date.wday<6)?"dinner_wkdy":"dinner_wknd" if meal.e_type =~ /dinner/
    time = Time.now - 900 < Time.parse(meal.time, meal.date)
    if meal.uname.empty?
      return "#{pt1} Meal Missed" unless time
      return pt1
    else 
      name = BrothersPersonal.find_by(uname: meal.uname).full_name
      return "#{pt1} #{name} -- #{meal.value}" if  Time.now > Time.parse(meal.time, meal.date)
      return "#{pt1} #{name}"
    end
  end
  
end
