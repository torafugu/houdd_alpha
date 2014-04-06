class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.references :family
      t.string :name
      t.integer :longevity
      t.float :prolificacy
      t.float :growth_rate
      t.integer :food_cost
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :cha
      t.float :mutation_rate
      t.integer :phys_def
      t.integer :skill_def
      t.integer :ele_fw
      t.integer :ele_ld
      t.references :skill

      t.timestamps
    end
    add_index :species, :family_id
    add_index :species, :skill_id
  end
end
