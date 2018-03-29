# frozen_string_literal: true

include ActionView::Helpers::DateHelper

namespace :reminders do
  task send: :environment do
    User.needs_reminding.each do |user|
      text = "You haven't eaten since #{time_ago_in_words user.last_meal_at} ago. Maybe grab some food?"
      Telegram.bot.send_message(chat_id: user.telegram_id, text: text)
      user.touch :reminded_at
    end
  end
end
