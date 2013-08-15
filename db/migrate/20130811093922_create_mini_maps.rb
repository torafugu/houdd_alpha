class CreateMiniMaps < ActiveRecord::Migration
  def change
    create_table :mini_maps do |t|
      t.references :houdd_user
      t.string :name
      t.integer :size
      t.boolean :hq_flg
      t.string :type_symbol
      t.boolean :find_root_flg

      t.timestamps
    end
    add_index :mini_maps, :houdd_user_id
  end
end
