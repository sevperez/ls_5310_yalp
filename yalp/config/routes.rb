Rails.application.routes.draw do
  root to: "pages#front"
  
  # Users
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  
  # UI mockup controller -- development only
  get "ui(/:action)", controller: "ui"
end
