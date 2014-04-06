class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :type_symbol
      t.string :element_symbol
      t.string :name
      t.integer :sp_cost
      t.integer :num_of_tgt
      t.integer :hit_accuracy
      t.integer :range
      t.integer :damage
      t.integer :heal
      t.float :str_mod
      t.float :dex_mod
      t.float :con_mod
      t.float :int_mod
      t.float :wis_mod
      t.float :cha_mod
      t.float :ele_fw_mod
      t.float :ele_ld_mod
      t.float :phys_def_mod
      t.float :skill_def_mod
      t.integer :duration
      t.integer :cast_cycle
      t.integer :research_level

      t.timestamps
    end
  end
end
