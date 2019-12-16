# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
