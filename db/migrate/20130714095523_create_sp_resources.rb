class CreateSpResources < ActiveRecord::Migration
  def change
    create_table :sp_resources do |t|
      t.references :terrain
      t.string :symbol
      t.string :name
      t.integer :food
      t.integer :production
      t.integer :money
      t.integer :frequency_rate

      t.timestamps
    end
    add_index :sp_resources, :terrain_id
  end
end
