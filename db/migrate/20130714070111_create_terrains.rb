class CreateTerrains < ActiveRecord::Migration
  def change
    create_table :terrains do |t|
      t.string :symbol
      t.string :name
      t.integer :food
      t.integer :production
      t.integer :money
      t.integer :frequency_rate
      t.integer :continuity_mod

      t.timestamps
    end
  end
end
