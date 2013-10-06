class CreateSkillCategories < ActiveRecord::Migration
  def change
    create_table :skill_categories do |t|
      t.string :type_sym
      t.string :element_sym

      t.timestamps
    end
  end
end
