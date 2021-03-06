# frozen_string_literal: true

class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.integer :immo_id

      t.timestamps
    end
    add_index :flats, :immo_id, unique: true
  end
end
