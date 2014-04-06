class CreateExpInvs < ActiveRecord::Migration
  def change
    create_table :exp_invs do |t|
      t.string :type
      t.references :mob
      t.integer :owner_id
      t.integer :level
      t.integer :exp

      t.timestamps
    end
    add_index :exp_invs, :mob_id
  end
end
