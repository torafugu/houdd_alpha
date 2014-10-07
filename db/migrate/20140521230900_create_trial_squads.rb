class CreateTrialSquads < ActiveRecord::Migration
  def change
    create_table :trial_squads do |t|
      t.references :trial
      t.integer :squad_id
      t.string :name
      t.boolean :intruder_flg

      t.timestamps
    end
    add_index :trial_squads, :trial_id
  end
end
