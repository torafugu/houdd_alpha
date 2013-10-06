class CreateSpecieJobInvs < ActiveRecord::Migration
  def change
    create_table :specie_job_invs do |t|
      t.references :specie
      t.references :job
      t.integer :frequency_rate

      t.timestamps
    end
    add_index :specie_job_invs, :specie_id
    add_index :specie_job_invs, :job_id
  end
end
