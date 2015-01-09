Rails.application.routes.draw do
  scope module: "house_points" do
    
    scope "officers/:officer_id" do
      resources :point_entries, only: [:index, :new, :create]
    end
    resources :point_entries, only: [:show, :edit, :update, :destroy]
    
  end
end
