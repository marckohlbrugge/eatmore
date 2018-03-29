# frozen_string_literal: true

Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  resources :users, only: [:show]

  root to: "pages#home"
end
