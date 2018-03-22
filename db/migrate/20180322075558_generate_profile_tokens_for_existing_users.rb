class GenerateProfileTokensForExistingUsers < ActiveRecord::Migration[5.2]
  def change
    User.find_each do |user|
      user.regenerate_profile_token
    end
  end
end
