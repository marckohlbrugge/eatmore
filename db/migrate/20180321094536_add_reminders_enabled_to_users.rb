# frozen_string_literal: true

class AddRemindersEnabledToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reminders_enabled, :boolean, default: true
  end
end
