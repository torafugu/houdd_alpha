class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :mini_map
      t.string :map_name
      t.integer :guard_mission_id
      t.integer :intruder_mission_id
      t.integer :occured_at

      t.timestamps
    end
    add_index :trials, :mini_map_id
  end
end
