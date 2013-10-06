class CreateSquads < ActiveRecord::Migration
  def change
    create_table :squads do |t|
      t.references :houdd_user
      t.references :mini_map
      t.string :name

      t.timestamps
    end
    add_index :squads, :houdd_user_id
    add_index :squads, :mini_map_id
  end
end
