class CreateMiniMapCells < ActiveRecord::Migration
  def change
    create_table :mini_map_cells do |t|
      t.references :mini_map
      t.integer :x
      t.integer :y
      t.references :terrain
      t.references :sp_resource
      t.references :construction
      t.integer :built_point
      t.boolean :active_flg
      t.boolean :capital_flg

      t.timestamps
    end
    add_index :mini_map_cells, :mini_map_id
    add_index :mini_map_cells, :terrain_id
    add_index :mini_map_cells, :sp_resource_id
    add_index :mini_map_cells, :construction_id
  end
end
