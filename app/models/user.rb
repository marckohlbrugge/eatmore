class User < ApplicationRecord
  has_many :meals

  scope :needs_reminding, -> { joins(:meals).where(reminders_enabled: true).not("meals.created_at > ?", 8.hours.ago) }

  def to_param
    username
  end

  def last_meal_at
    meals.newest.created_at
  end
end
