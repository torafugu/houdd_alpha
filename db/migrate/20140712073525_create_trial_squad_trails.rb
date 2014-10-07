class CreateTrialSquadTrails < ActiveRecord::Migration
  def change
    create_table :trial_squad_trails do |t|
      t.references :trial_move_turn
      t.references :trial_squad
      t.integer :from_x
      t.integer :from_y
      t.integer :to_x
      t.integer :to_y

      t.timestamps
    end
    add_index :trial_squad_trails, :trial_move_turn_id
    add_index :trial_squad_trails, :trial_squad_id
  end
end
