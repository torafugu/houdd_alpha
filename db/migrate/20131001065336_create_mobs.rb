class CreateMobs < ActiveRecord::Migration
  def change
    create_table :mobs do |t|
      t.references :houdd_user
      t.references :specie
      t.integer :father_id
      t.integer :mother_id
      t.integer :generation
      t.references :job
      t.references :squad
      t.string :name
      t.string :gender_sym
      t.integer :age
      t.integer :hp
      t.integer :sp
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :cha
      t.integer :phys_def
      t.integer :skill_def
      t.integer :ele_fw
      t.integer :ele_ld
      t.boolean :natural_death_flg

      t.timestamps
    end
    add_index :mobs, :houdd_user_id
    add_index :mobs, :specie_id
    add_index :mobs, :job_id
    add_index :mobs, :squad_id
  end
end
