Rails.application.routes.draw do
  
  scope module: 'epsilon' do
    match "/meal_plan", to: "meal_plan#roster", via: :get
    match "/meal_plan/filter", to: "meal_plan#filter", via: :post
    match "/meal_plan/toggle", to: "meal_plan#toggle", via: :post
    
    match "/schedule", to: "epsilon#meal_schedule", via: :get
  end
  
end
