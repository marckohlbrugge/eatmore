# frozen_string_literal: true

class GenerateProfileTokensForExistingUsers < ActiveRecord::Migration[5.2]
  def change
    User.find_each(&:regenerate_profile_token)
  end
end
