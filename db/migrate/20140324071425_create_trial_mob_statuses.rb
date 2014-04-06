class CreateTrialMobStatuses < ActiveRecord::Migration
  def change
    drop_table :trial_mob_statuses
    create_table :trial_mob_statuses do |t|
      t.references :trial_move_turn
      t.references :trial_mob
      t.integer :end_hp
      t.integer :end_sp
      t.string :end_status

      t.timestamps
    end
    add_index :trial_mob_statuses, :trial_move_turn_id
    add_index :trial_mob_statuses, :trial_mob_id
  end
end
