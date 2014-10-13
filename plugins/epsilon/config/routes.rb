Rails.application.routes.draw do
  
  scope module: 'epsilon' do
    match "/meal_plan", to: "meal_plan#roster", via: :get
    match "/meal_plan", to: "meal_plan#update", via: :post
    match "/meal_plan/filter", to: "meal_plan#filter", via: :post
  end
  
end
