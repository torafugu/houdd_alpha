class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.references :houdd_user
      t.references :mini_map
      t.string :category_symbol
      t.references :mission_strategy
      t.string :status_symbol
      t.decimal :start_houdd_time, :precision => 10, :scale => 3
      t.decimal :end_houdd_time, :precision => 10, :scale => 3

      t.timestamps
    end
    add_index :missions, :houdd_user_id
    add_index :missions, :mini_map_id
    add_index :missions, :mission_strategy_id
  end
end
