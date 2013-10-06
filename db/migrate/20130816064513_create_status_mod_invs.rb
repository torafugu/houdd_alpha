class CreateStatusModInvs < ActiveRecord::Migration
  def change
    create_table :status_mod_invs do |t|
      t.string :type
      t.references :status_mod
      t.integer :owner_id
      t.integer :num_of_tgt
      t.integer :duration

      t.timestamps
    end
    add_index :status_mod_invs, :status_mod_id
  end
end
