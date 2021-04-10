# frozen_string_literal: true
include ActionView::Helpers::DateHelper

namespace :reminders do
  task send: :environment do
    User.needs_reminding.each do |user|
      time_ago_in_words = time_ago_in_words(user.last_meal_at)
      text = "You haven't eaten since #{time_ago_in_words} ago. Maybe grab some food?\n\nTurn off reminders with /reminders"

      begin
        Telegram.bot.send_message(chat_id: user.telegram_id, text: text)
      rescue Telegram::Bot::Forbidden
        # Ignore
      rescue Telegram::Bot::Error
        # Ignore
      end

      user.touch_reminded_at
    end
  end
end
