class CreateSkillInvs < ActiveRecord::Migration
  def change
    create_table :skill_invs do |t|
      t.string :type
      t.references :skill
      t.integer :owner_id

      t.timestamps
    end
    add_index :skill_invs, :skill_id
  end
end
