class CreateDnas < ActiveRecord::Migration
  def change
    create_table :dnas do |t|
      t.references :mob
      t.references :gene

      t.timestamps
    end
    add_index :dnas, :mob_id
    add_index :dnas, :gene_id
  end
end
