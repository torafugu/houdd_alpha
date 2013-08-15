class CreateMiniMapRoads < ActiveRecord::Migration
  def change
    create_table :mini_map_roads do |t|
      t.integer :start_mini_map_id
      t.integer :end_mini_map_id
      t.integer :distance
      t.integer :level
      t.integer :built_point
      t.boolean :active_flg

      t.timestamps
    end
  end
end
