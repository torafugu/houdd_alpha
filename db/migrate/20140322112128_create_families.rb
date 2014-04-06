class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.boolean :asexual_flg
      t.references :skill

      t.timestamps
    end
    add_index :families, :skill_id
  end
end
