# frozen_string_literal: true

class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :image_data

      t.timestamps
    end
  end
end
