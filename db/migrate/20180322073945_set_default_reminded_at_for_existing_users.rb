class SetDefaultRemindedAtForExistingUsers < ActiveRecord::Migration[5.2]
  def change
    User.find_each do |user|
      user.send(:set_reminded_at)
      user.save
    end
  end
end
