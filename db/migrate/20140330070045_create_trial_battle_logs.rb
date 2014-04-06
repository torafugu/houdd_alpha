class CreateTrialBattleLogs < ActiveRecord::Migration
  def change
    create_table :trial_battle_logs do |t|
      t.references :trial_move_turn
      t.references :trial_mob
      t.integer :vpos
      t.integer :target_mob_id
      t.boolean :target_dead_flg
      t.integer :damage
      t.string :method_txt

      t.timestamps
    end
    add_index :trial_battle_logs, :trial_move_turn_id
    add_index :trial_battle_logs, :trial_mob_id
  end
end
