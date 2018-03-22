class AddProfileTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_token, :string
    add_index :users, :profile_token, unique: true
  end
end
