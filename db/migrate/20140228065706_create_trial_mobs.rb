class CreateTrialMobs < ActiveRecord::Migration
  def change
    create_table :trial_mobs do |t|
      t.references :trial_squad
      t.integer :mob_id
      t.string :name
      t.string :job_name
      t.integer :max_hp
      t.integer :max_sp

      t.timestamps
    end
    add_index :trial_mobs, :trial_squad_id
  end
end
