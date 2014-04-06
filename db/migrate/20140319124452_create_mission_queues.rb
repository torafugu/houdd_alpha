class CreateMissionQueues < ActiveRecord::Migration
  def change
    create_table :mission_queues do |t|
      t.references :mission
      t.references :squad
      t.integer :priority

      t.timestamps
    end
    add_index :mission_queues, :mission_id
    add_index :mission_queues, :squad_id
  end
end
