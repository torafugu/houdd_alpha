class CreateTrialFortressCells < ActiveRecord::Migration
  def change
    create_table :trial_fortress_cells do |t|
      t.references :trial
      t.string :symbol
      t.integer :x
      t.integer :y
      t.boolean :trap_flg
      t.boolean :goal_flg

      t.timestamps
    end
    add_index :trial_fortress_cells, :trial_id
  end
end
