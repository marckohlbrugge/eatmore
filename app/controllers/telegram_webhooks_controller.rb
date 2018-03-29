class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def start(*)
    text = %{
      👋 Hi there,

I will help you eat more. Here's how it works:

Every time you eat a meal. Snap a picture and send it to me. Make sure to send it as a photo and not a file. You can add a caption to the photo if you'd like.

Type /meals to see all the meals you've eaten.
Type /link to get a secret link to your private profile

You can turn on /reminders to get notified when you haven't eaten in a while. Type /reminders to toggle your reminders on/off.

Bon appetite!
    }
    respond_with :message, text: text
  end

  def message(*)
    return unless payload["photo"].present?

    photo = payload["photo"].sort_by { |p| p["file_size"] }.last
    file_id = photo["file_id"]
    file = bot.get_file(file_id: file_id)

    remote_url = "https://api.telegram.org/file/bot#{ENV.fetch("TELEGRAM_BOT_TOKEN")}/#{file["result"]["file_path"]}"

    previous_meal_at = last_meal_at
    user.meals.create name: payload["caption"], image_remote_url: remote_url, created_at: payload_timestamp

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

  def link(*)
    respond_with :message, text: user_url(user, host: ENV.fetch("HOST"))
  end

  def botstats(*)
    respond_with :message, text: "#{User.count} users, #{Meal.count} meals."
  end

  def meals(*)
    lines = user.meals.order(created_at: :desc).collect do |meal|
      "#{time_ago_in_words meal.created_at} ago – #{meal.name || "(no description)"}"
    end

    text = if lines.any?
             lines.join("\n")
           else
             "No meals logged yet."
           end

    respond_with :message, text: text
  end

  def reminders(*)
    user.toggle! :reminders_enabled

    text = if user.reminders_enabled?
             "🚨 Reminders are turned on. Type /reminders to turn them off."
           else
             "😶 Reminders are turned off. Type /reminders to turn them on."
           end

    respond_with :message, text: text
  end

  rescue_from Telegram::Bot::Forbidden do
    # Forbidden: bot was blocked by the user
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

  def payload_timestamp
    Time.at payload["date"]
  end
end
