Rails.application.routes.draw do
  devise_for :users
  get "/migration_status", to: "homes#migration_status"
  post "/", to: "homes#index"
  root to: "homes#index"
end
