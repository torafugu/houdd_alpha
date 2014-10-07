class CreateTrialMobStatuses < ActiveRecord::Migration
  def change
    create_table :trial_mob_statuses do |t|
      t.references :trial_battle_turn
      t.references :trial_mob
      t.integer :vpos
      t.integer :start_hp
      t.integer :end_hp
      t.integer :start_sp
      t.integer :end_sp
      t.string :start_status
      t.string :end_status

      t.timestamps
    end
    add_index :trial_mob_statuses, :trial_battle_turn_id
    add_index :trial_mob_statuses, :trial_mob_id
  end
end
