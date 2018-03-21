Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  get "@:id", to: "users#show", as: :user

  root to: "users#index"
end
