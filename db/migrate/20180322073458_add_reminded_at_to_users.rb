# frozen_string_literal: true

class AddRemindedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reminded_at, :datetime
  end
end
