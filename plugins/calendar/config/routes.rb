Rails.application.routes.draw do
  
  scope module: "calendar" do
    match "/calendar", to: 'events#calendar', via: :get
    resources :events
  end
end
