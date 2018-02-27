Rails.application.routes.draw do
  root to: "pages#front"
  
  # Users
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  resources :users, only: [:show, :edit, :update]
  
  # Sessions
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"
  get "/sign_out", to: "sessions#destroy"
  
  # Businesses
  resources :businesses, only: [:index, :show, :new, :create] do
    member do
      post "/review", to: "reviews#create"
    end
    
    collection do
      get "/search", to: "businesses#search"
    end
  end
  
  # Reviews
  resources :reviews, only: [:index]
  
  # Categories
  resources :categories, only: [] do
    member do
      get "/businesses", to: "categories#businesses"
      get "/reviews", to: "categories#reviews"
    end
  end
  
  # UI mockup controller -- development only
  get "ui(/:action)", controller: "ui"
end
