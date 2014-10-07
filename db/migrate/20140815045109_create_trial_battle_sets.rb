class CreateTrialBattleSets < ActiveRecord::Migration
  def change
    create_table :trial_battle_sets do |t|
      t.references :trial_move_turn
      t.references :attacker_squad
      t.references :defender_squad
      t.integer :distance

      t.timestamps
    end
    add_index :trial_battle_sets, :trial_move_turn_id
    add_index :trial_battle_sets, :attacker_squad_id
    add_index :trial_battle_sets, :defender_squad_id
  end
end
