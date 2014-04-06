class CreateProductionQueues < ActiveRecord::Migration
  def change
    create_table :production_queues do |t|
      t.references :houdd_user
      t.string :symbol
      t.integer :queue_id
      t.integer :priority
      t.integer :allotment
      t.boolean :destroy_flg

      t.timestamps
    end
    add_index :production_queues, :houdd_user_id
  end
end
