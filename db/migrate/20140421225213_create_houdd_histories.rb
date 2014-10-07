class CreateHouddHistories < ActiveRecord::Migration
  def change
    create_table :houdd_histories do |t|
      t.string :exp_inv
      t.integer :day
      t.text :log

      t.timestamps
    end
  end
end
