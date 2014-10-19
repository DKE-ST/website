Rails.application.routes.draw do
  
  scope module: 'epsilon' do
    match "/meal_plan", to: "meal_plan#roster", via: :get
    match "/meal_plan/filter", to: "meal_plan#filter", via: :post
    match "/meal_plan/toggle", to: "meal_plan#toggle", via: :post
    
    scope "/epsilon" do
      match "/new_meal", to: "epsilon#new_meal", via: :get
      match "/new_week", to: "epsilon#new_week", via: :patch
      resources :e_sheets, path: "/schedule"
    end
    resources :epsilon
  end
  
end
