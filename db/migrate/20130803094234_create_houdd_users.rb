class CreateHouddUsers < ActiveRecord::Migration
  def change
    create_table :houdd_users do |t|
      t.string :name
      t.boolean :admin_flg
      t.string :login_id
      t.string :login_pw
      t.datetime :last_login_at
      t.boolean :active_flg
      t.integer :allot_for_item
      t.integer :allot_for_const
      t.integer :allot_for_research

      t.timestamps
    end
  end
end
