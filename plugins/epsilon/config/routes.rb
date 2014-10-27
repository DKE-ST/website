Rails.application.routes.draw do
  
  scope module: 'epsilon' do
    match "/meal_plan", to: "meal_plan#roster", via: :get
    match "/meal_plan/filter", to: "meal_plan#filter", via: :post
    match "/meal_plan/toggle", to: "meal_plan#toggle", via: :post
    
    scope "/epsilon" do
      match "/new_meal", to: "epsilon#new_meal", via: :get
      match "/new_week", to: "epsilon#new_week", via: :patch
      match "/update_e_count", to: "epsilon#update_e_count", via: :patch
      resources :e_templates, path: "/schedule"
    end
    resources :epsilon
    
    match "/e_sheet", to: "e_sheets#auth_sheet", via: :get
    match "/e_sheet", to: "e_sheets#auth_sign_up", via: :patch
    
    match "/public_sheet", to: "e_sheets#public_sheet", via: :get
    match "/public_sheet", to: "e_sheets#public_sign_up", via: :patch
  end
  
end
