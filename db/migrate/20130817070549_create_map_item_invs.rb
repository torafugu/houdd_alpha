class CreateMapItemInvs < ActiveRecord::Migration
  def change
    create_table :map_item_invs do |t|
      t.references :mini_map
      t.references :item

      t.timestamps
    end
    add_index :map_item_invs, :mini_map_id
    add_index :map_item_invs, :item_id
  end
end
