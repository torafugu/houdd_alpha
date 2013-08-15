class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.references :houdd_user
      t.string :symbol
      t.integer :level
      t.integer :allotment
      t.integer :invested_point

      t.timestamps
    end
    add_index :researches, :houdd_user_id
  end
end
