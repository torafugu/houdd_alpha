# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130811093922) do

  create_table "constructions", :force => true do |t|
    t.integer  "terrain_id"
    t.string   "symbol"
    t.string   "name"
    t.integer  "food"
    t.integer  "production"
    t.integer  "money"
    t.integer  "rq_prod_point"
    t.integer  "rq_days"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "constructions", ["terrain_id"], :name => "index_constructions_on_terrain_id"

  create_table "fortress_cells", :force => true do |t|
    t.integer  "mini_map_id"
    t.string   "symbol"
    t.integer  "x"
    t.integer  "y"
    t.integer  "trap_id"
    t.integer  "squad_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "fortress_cells", ["mini_map_id"], :name => "index_fortress_cells_on_mini_map_id"

  create_table "houdd_users", :force => true do |t|
    t.string   "name"
    t.boolean  "admin_flg"
    t.string   "login_id"
    t.string   "login_pw"
    t.datetime "last_login_at"
    t.boolean  "active_flg"
    t.integer  "allot_for_item"
    t.integer  "allot_for_const"
    t.integer  "allot_for_research"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "mini_map_cells", :force => true do |t|
    t.integer  "mini_map_id"
    t.integer  "x"
    t.integer  "y"
    t.integer  "terrain_id"
    t.integer  "sp_resource_id"
    t.integer  "construction_id"
    t.integer  "built_point"
    t.boolean  "const_active_flg"
    t.boolean  "capital_flg"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "mini_map_cells", ["construction_id"], :name => "index_mini_map_cells_on_construction_id"
  add_index "mini_map_cells", ["mini_map_id"], :name => "index_mini_map_cells_on_mini_map_id"
  add_index "mini_map_cells", ["sp_resource_id"], :name => "index_mini_map_cells_on_sp_resource_id"
  add_index "mini_map_cells", ["terrain_id"], :name => "index_mini_map_cells_on_terrain_id"

  create_table "mini_map_roads", :force => true do |t|
    t.integer  "start_mini_map_id"
    t.integer  "end_mini_map_id"
    t.integer  "distance"
    t.integer  "level"
    t.integer  "built_point"
    t.boolean  "active_flg"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "mini_maps", :force => true do |t|
    t.integer  "houdd_user_id"
    t.string   "name"
    t.integer  "size"
    t.boolean  "hq_flg"
    t.string   "type_symbol"
    t.boolean  "find_root_flg"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mini_maps", ["houdd_user_id"], :name => "index_mini_maps_on_houdd_user_id"

  create_table "production_ques", :force => true do |t|
    t.integer  "houdd_user_id"
    t.string   "symbol"
    t.integer  "que_id"
    t.integer  "priority"
    t.integer  "allotment"
    t.boolean  "destroy_flg"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "production_ques", ["houdd_user_id"], :name => "index_production_ques_on_houdd_user_id"

  create_table "researches", :force => true do |t|
    t.integer  "houdd_user_id"
    t.string   "symbol"
    t.integer  "level"
    t.integer  "allotment"
    t.integer  "invested_point"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "researches", ["houdd_user_id"], :name => "index_researches_on_houdd_user_id"

  create_table "sp_resources", :force => true do |t|
    t.integer  "terrain_id"
    t.string   "symbol"
    t.string   "name"
    t.integer  "food"
    t.integer  "production"
    t.integer  "money"
    t.integer  "frequency_rate"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "sp_resources", ["terrain_id"], :name => "index_sp_resources_on_terrain_id"

  create_table "terrains", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.integer  "food"
    t.integer  "production"
    t.integer  "money"
    t.integer  "frequency_rate"
    t.integer  "continuity_mod"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
