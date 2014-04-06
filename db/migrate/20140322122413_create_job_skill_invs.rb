class CreateJobSkillInvs < ActiveRecord::Migration
  def change
    create_table :job_skill_invs do |t|
      t.references :skill
      t.references :job

      t.timestamps
    end
    add_index :job_skill_invs, :skill_id
    add_index :job_skill_invs, :job_id
  end
end
