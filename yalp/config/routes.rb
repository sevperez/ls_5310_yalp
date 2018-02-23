Rails.application.routes.draw do
  root to: "pages#front"
  
  # Users
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  
  # Sessions
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  get "/sign_out", to: "sessions#destroy"
  
  # Businesses
  resources :businesses, only: [:index, :show]
  
  # UI mockup controller -- development only
  get "ui(/:action)", controller: "ui"
end
