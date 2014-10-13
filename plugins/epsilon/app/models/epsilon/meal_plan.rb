module Epsilon
  class MealPlan < User::Brother::DkeInfo
    #meal_plan tinyint(1)
    
    ################Static Methods ######################
  #Returns list of users filtered by params
  #@param params: fields to filter users by
  #@return list of hashes with user information
  def self.list(params = {})
    brother_list = []
    brothers = self
    brothers = brothers.where(meal_plan: params["meal_plan"] == "true") unless params["meal_plan"].blank?
    brothers.select("*").each do | dkeinfo |
      entry = {id: dkeinfo.id,
               first_name: dkeinfo.brother.first_name,
               last_name: dkeinfo.brother.last_name,
               year: dkeinfo.brother.mit_info.year,
               meal_plan: dkeinfo.meal_plan,
               residence: !dkeinfo.residence.nil?}
      
      default_check = (entry[:year] > MealPlan.cur_p_class - 4) || !entry[:residence].blank? || entry[:meal_plan]
      class_check = (default_check && params["year"].blank?) || (entry[:year].to_i == params["year"].to_i)
      house_check = params["house"].blank? || (entry[:residence].blank? ^ (params["house"] == "True"))
      brother_list << entry if class_check && house_check
    end
    brother_list.sort_by!{ |a| [a[:year], a[:last_name], a[:first_name]]}
    return brother_list
  end
    
    def self.meal_plan_list
      brothers = Array.new([])
      MealPlan.where(meal_plan: 1).each do | user |
        brothers << [user.brother.full_name, user.id]
      end
      brothers.sort!
      return brothers
    end
    
  end
end
