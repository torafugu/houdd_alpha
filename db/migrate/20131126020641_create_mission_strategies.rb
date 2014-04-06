class CreateMissionStrategies < ActiveRecord::Migration
  def change
    create_table :mission_strategies do |t|
      t.references :houdd_user
      t.string :name
      t.text :script

      t.timestamps
    end
    add_index :mission_strategies, :houdd_user_id
  end
end
