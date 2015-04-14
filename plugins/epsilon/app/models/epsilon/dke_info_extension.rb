User::Brother::DkeInfo.class_eval do
  #meal_plan tinyint(1)
  has_many :e_served, class_name: "Epsilon::ESheet"
  
  def e_status
    day = Date.today + 1
    mon = day - day.days_to_week_start
    tot = 0
    self.e_served.where("date < ?", mon).each do | e |
      puts e.value
      tot += e.value
    end
    return tot
  end
  
  ################Static Methods ######################
  #Override of default find_by method to simplify querying a meal_plan_user by mit_id number
  def self.find_by(params)
    if params.include? :mit_id
      usr = User.find_by(params)
      begin
        return usr.brother.dke_info
      rescue
        return nil
      end 
    else
      return super(params)
    end
  end
  
  def self.list_dropdown(params = {})
    brothers = Hash.new
    brothers[""] = [["","null"]]
    self.list(params).each do | brother |
      brothers[brother[:year]] = Array.new([]) if !brothers.include? brother[:year]
      brothers[brother[:year]] << ["#{brother[:first_name]} #{brother[:last_name]}", brother[:id]]
    end
    brothers.each do |key, value|
      value.sort!
    end
    return brothers
  end
  
  #Returns list of users filtered by params
  #@param params: fields to filter users by
  #@return list of hashes with user information
  def self.list(params = {})
    brother_list = []
    brothers = self
    brothers = brothers.where(meal_plan: params["meal_plan"].to_s == "true") unless params["meal_plan"].blank?
    brothers.select("*").each do | dkeinfo |
      entry = {id: dkeinfo.id,
               first_name: dkeinfo.brother.first_name,
               last_name: dkeinfo.brother.last_name,
               year: dkeinfo.brother.mit_info.year,
               meal_plan: dkeinfo.meal_plan,
               residence: !dkeinfo.residence.nil?}
      
      default_check = (entry[:year] > self.cur_p_class - 4) || !entry[:residence].blank? || entry[:meal_plan]
      class_check = (default_check && params["year"].blank?) || (entry[:year].to_i == params["year"].to_i)
      house_check = params["house"].blank? || (entry[:residence].blank? ^ (params["house"] == "True"))
      brother_list << entry if class_check && house_check
    end
    brother_list.sort_by!{ |a| [a[:year], a[:last_name], a[:first_name]]}
    return brother_list
  end
end
