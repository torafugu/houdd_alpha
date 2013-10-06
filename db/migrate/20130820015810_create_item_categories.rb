class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :type_sym
      t.string :name
      t.references :body_part
      t.integer :rq_slot_num

      t.timestamps
    end
    add_index :item_categories, :body_part_id
  end
end
