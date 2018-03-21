class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include ActionView::Helpers::DateHelper

  def start(*)
    respond_with :message, text: "Hi!"
  end


  def message(*)
    return unless payload["photo"].present?

    photo = payload["photo"].sort_by { |p| p["file_size"] }.last
    file_id = photo["file_id"]
    file = bot.get_file(file_id: file_id)

    remote_url = "https://api.telegram.org/file/bot#{ENV.fetch("TELEGRAM_BOT_TOKEN")}/#{file["result"]["file_path"]}"

    previous_meal_at = last_meal_at
    user.meals.create name: payload["caption"], image_remote_url: remote_url

    status = if previous_meal_at
              "previous meal was #{time_ago_in_words(previous_meal_at)} ago"
             else
               "Your first logged meal. Yay!"
             end

    respond_with :message, text: "Your meal was logged! (#{status})"
  end

  def last(*)
    respond_with :message, text: "Your last meal was #{time_ago_in_words(last_meal_at)} ago"
  end

  def meals(*)
    lines = user.meals.collect do |meal|
      "#{meal.created_at} – #{meal.name}"
    end

    respond_with :message, text: lines.join("\n")
  end

  private

  def user
    user = User.where(telegram_id: payload["from"]["id"]).first_or_create
    user.update username: payload["from"]["username"]
    user
  end

  def last_meal_at
    user.meals.maximum(:created_at)
  end

end
