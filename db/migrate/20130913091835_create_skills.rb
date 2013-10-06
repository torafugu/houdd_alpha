class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :skill_category
      t.string :name
      t.integer :sp_cost
      t.integer :research_level

      t.timestamps
    end
    add_index :skills, :skill_category_id
  end
end
