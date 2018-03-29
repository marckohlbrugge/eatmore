# frozen_string_literal: true

Telegram.bots_config = {
  default: {
    token: ENV.fetch("TELEGRAM_BOT_TOKEN"),
    username: ENV.fetch("TELEGRAM_BOT_USERNAME")
  }
}
