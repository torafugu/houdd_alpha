class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :item_info
      t.references :houdd_user
      t.references :mob
      t.integer :dp
      t.integer :quality
      t.integer :built_point
      t.boolean :active_flg

      t.timestamps
    end
    add_index :items, :item_info_id
    add_index :items, :houdd_user_id
    add_index :items, :mob_id
  end
end
