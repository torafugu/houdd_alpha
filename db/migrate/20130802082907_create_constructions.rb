class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.references :terrain
      t.string :symbol
      t.string :name
      t.integer :food
      t.integer :production
      t.integer :money
      t.integer :rq_prod_point
      t.integer :rq_days

      t.timestamps
    end
    add_index :constructions, :terrain_id
  end
end
