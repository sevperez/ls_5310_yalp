Rails.application.routes.draw do
  # Users
  resources :users, only: [:new, :create]
  
  # UI mockup controller -- development only
  get "ui(/:action)", controller: "ui"
end
