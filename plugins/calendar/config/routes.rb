Rails.application.routes.draw do
  
  scope module: "calendar" do
    match "/calendar", to: 'events#calendar', via: :get
    match "/events/mit_reg", to: 'events#mit_events', via: :get
    resources :events
  end
end
