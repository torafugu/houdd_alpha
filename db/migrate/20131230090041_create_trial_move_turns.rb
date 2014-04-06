class CreateTrialMoveTurns < ActiveRecord::Migration
  def change
    create_table :trial_move_turns do |t|
      t.references :trial
      t.text :log

      t.timestamps
    end
    add_index :trial_move_turns, :trial_id
  end
end
