# frozen_string_literal: true

class AddUserReferencesToMeals < ActiveRecord::Migration[5.1]
  def change
    add_reference :meals, :user, foreign_key: true
  end
end
