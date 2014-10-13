module Epsilon
  module MealPlanHelper
    
    #################Index.html.erb########################
    #Filter select options for index page
    def class_select_filter
      class_options = User::Brother::MitInfo.uniq.pluck("year").sort.reverse
      return select_tag("filter[class]", options_for_select([""] + class_options), class: "filter_select")
    end
    
    def house_select_filter
      return select_tag("filter[house]", options_for_select(["", "True", "False"]), class: "filter_select")
    end
    
    def meal_plan_select_filter
      meal_plan_options = ["", true, false]
      return select_tag("filter[meal_plan]", options_for_select(meal_plan_options), class: "filter_select")
    end
  end
end