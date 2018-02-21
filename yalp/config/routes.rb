Rails.application.routes.draw do
  # UI mockup controller -- development only
  get "ui(/:action)", controller: "ui"
end
