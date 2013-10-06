class CreateItemInfos < ActiveRecord::Migration
  def change
    create_table :item_infos do |t|
      t.references :item_category
      t.integer :size
      t.integer :weight_level
      t.string :name
      t.integer :max_dp
      t.integer :rq_prod_point
      t.integer :research_level

      t.timestamps
    end
    add_index :item_infos, :item_category_id
  end
end
