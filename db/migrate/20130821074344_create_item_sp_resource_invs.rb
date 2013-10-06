class CreateItemSpResourceInvs < ActiveRecord::Migration
  def change
    create_table :item_sp_resource_invs do |t|
      t.references :item_info
      t.references :sp_resource

      t.timestamps
    end
    add_index :item_sp_resource_invs, :item_info_id
    add_index :item_sp_resource_invs, :sp_resource_id
  end
end
