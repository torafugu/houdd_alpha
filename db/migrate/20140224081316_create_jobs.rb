class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :type_symbol
      t.string :name
      t.float :growth_penalty
      t.integer :wepon_lvl
      t.integer :armor_lvl
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

      t.timestamps
    end
  end
end
