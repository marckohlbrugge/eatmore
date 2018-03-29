# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_token :profile_token

  has_many :meals

  scope :needs_reminding, lambda {
    joins(:meals)
      .where(reminders_enabled: true)
      .where.not("meals.created_at > ?", 6.hours.ago)
      .where.not("reminded_at > ?", 3.hours.ago)
      .distinct
  }

  before_create :set_reminded_at

  def to_param
    profile_token
  end

  def last_meal_at
    meals.newest.created_at
  end

  private

  def set_reminded_at
    self.reminded_at = Time.now
  end
end
