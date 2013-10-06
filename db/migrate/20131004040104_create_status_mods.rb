class CreateStatusMods < ActiveRecord::Migration
  def change
    create_table :status_mods do |t|
      t.string :name
      t.integer :hit_accuracy
      t.integer :d_range
      t.integer :x_range
      t.integer :hp_damage
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
