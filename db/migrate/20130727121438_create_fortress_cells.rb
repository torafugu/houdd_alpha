class CreateFortressCells < ActiveRecord::Migration
  def change
    create_table :fortress_cells do |t|
      t.references :mini_map
      t.string :symbol
      t.integer :x
      t.integer :y
      t.integer :trap_id
      t.integer :squad_id

      t.timestamps
    end
    add_index :fortress_cells, :mini_map_id
  end
end
