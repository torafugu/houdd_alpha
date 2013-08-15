class CreateProductionQues < ActiveRecord::Migration
  def change
    create_table :production_ques do |t|
      t.references :houdd_user
      t.string :symbol
      t.integer :que_id
      t.integer :priority
      t.integer :allotment
      t.boolean :destroy_flg

      t.timestamps
    end
    add_index :production_ques, :houdd_user_id
  end
end
