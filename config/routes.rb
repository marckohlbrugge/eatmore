Rails.application.routes.draw do
  resources :users, only: [:show]
  root to: "users#index"
end
