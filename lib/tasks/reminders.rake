# frozen_string_literal: true

namespace :reminders do
  task send: :environment do
    User.needs_reminding.each do |user|
      time_ago_in_words = ActionView::Helpers::DateHelper.time_ago_in_words user.last_meal_at
      text = "You haven't eaten since #{time_ago_in_words} ago. Maybe grab some food?"
      Telegram.bot.send_message(chat_id: user.telegram_id, text: text)
      user.touch_reminded_at
    end
  end
end
