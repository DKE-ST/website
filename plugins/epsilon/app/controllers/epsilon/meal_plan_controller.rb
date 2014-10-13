module Epsilon
  class MealPlanController < ApplicationController
    
    def roster
      @brothers = Epsilon::MealPlan.list
    end
    
    def filter
      @brothers = Epsilon::MealPlan.list(filter_params(params))
      render partial: 'filter', object: @brothers
    end
    
   private
   
    def filter_params(params)
      return params.permit("year", "house", "meal_plan")
    end
    
  end
end
