Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  resources :users, only: [:show]
  # get "@:id", to: "users#show", as: :user

  root to: "pages#home"
end
