class CreateItemInfos < ActiveRecord::Migration
  def change
    create_table :item_infos do |t|
      t.string :type_symbol
      t.string :element_symbol
      t.string :name
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
      t.references :family
      t.integer :weight_level
      t.integer :max_dp
      t.integer :rq_prod_point
      t.integer :atk_cycle
      t.integer :research_level

      t.timestamps
    end
    add_index :item_infos, :family_id
  end
end
