class CreateTrialBattleTurns < ActiveRecord::Migration
  def change
    create_table :trial_battle_turns do |t|
      t.references :trial_battle_set
      t.text :log

      t.timestamps
    end
    add_index :trial_battle_turns, :trial_battle_set_id
  end
end
