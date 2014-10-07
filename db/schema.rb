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

ActiveRecord::Schema.define(:version => 20140921223218) do

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

  create_table "dnas", :force => true do |t|
    t.integer  "mob_id"
    t.integer  "gene_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dnas", ["gene_id"], :name => "index_dnas_on_gene_id"
  add_index "dnas", ["mob_id"], :name => "index_dnas_on_mob_id"

  create_table "exp_invs", :force => true do |t|
    t.string   "type"
    t.integer  "mob_id"
    t.integer  "owner_id"
    t.integer  "level"
    t.integer  "exp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "exp_invs", ["mob_id"], :name => "index_exp_invs_on_mob_id"

  create_table "families", :force => true do |t|
    t.string   "name"
    t.boolean  "asexual_flg"
    t.integer  "skill_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "families", ["skill_id"], :name => "index_families_on_skill_id"

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

  create_table "genes", :force => true do |t|
    t.integer  "specie_id"
    t.boolean  "dominance_flg"
    t.float    "prolificacy_mod"
    t.float    "longevity_mod"
    t.float    "growth_mod"
    t.float    "food_cost_mod"
    t.float    "str_mod"
    t.float    "dex_mod"
    t.float    "con_mod"
    t.float    "int_mod"
    t.float    "wis_mod"
    t.float    "cha_mod"
    t.float    "ele_fw_mod"
    t.float    "ele_ld_mod"
    t.float    "phys_def_mod"
    t.float    "skill_def_mod"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "genes", ["specie_id"], :name => "index_genes_on_specie_id"

  create_table "houdd_histories", :force => true do |t|
    t.string   "exp_inv"
    t.integer  "day"
    t.text     "log"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "item_infos", :force => true do |t|
    t.string   "type_symbol"
    t.string   "element_symbol"
    t.string   "name"
    t.integer  "num_of_tgt"
    t.integer  "hit_accuracy"
    t.integer  "range"
    t.integer  "damage"
    t.integer  "heal"
    t.float    "str_mod"
    t.float    "dex_mod"
    t.float    "con_mod"
    t.float    "int_mod"
    t.float    "wis_mod"
    t.float    "cha_mod"
    t.float    "ele_fw_mod"
    t.float    "ele_ld_mod"
    t.float    "phys_def_mod"
    t.float    "skill_def_mod"
    t.integer  "duration"
    t.integer  "family_id"
    t.integer  "weight_level"
    t.integer  "max_dp"
    t.integer  "rq_prod_point"
    t.integer  "atk_cycle"
    t.integer  "research_level"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "item_infos", ["family_id"], :name => "index_item_infos_on_family_id"

  create_table "item_sp_resource_invs", :force => true do |t|
    t.integer  "item_info_id"
    t.integer  "sp_resource_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "item_sp_resource_invs", ["item_info_id"], :name => "index_item_sp_resource_invs_on_item_info_id"
  add_index "item_sp_resource_invs", ["sp_resource_id"], :name => "index_item_sp_resource_invs_on_sp_resource_id"

  create_table "items", :force => true do |t|
    t.integer  "item_info_id"
    t.integer  "houdd_user_id"
    t.integer  "mob_id"
    t.integer  "dp"
    t.integer  "quality"
    t.integer  "built_point"
    t.boolean  "active_flg"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "items", ["houdd_user_id"], :name => "index_items_on_houdd_user_id"
  add_index "items", ["item_info_id"], :name => "index_items_on_item_info_id"
  add_index "items", ["mob_id"], :name => "index_items_on_mob_id"

  create_table "job_skill_invs", :force => true do |t|
    t.integer  "skill_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "job_skill_invs", ["job_id"], :name => "index_job_skill_invs_on_job_id"
  add_index "job_skill_invs", ["skill_id"], :name => "index_job_skill_invs_on_skill_id"

  create_table "jobs", :force => true do |t|
    t.string   "type_symbol"
    t.string   "name"
    t.float    "growth_penalty"
    t.integer  "weapon_lvl"
    t.integer  "armor_lvl"
    t.float    "str_mod"
    t.float    "dex_mod"
    t.float    "con_mod"
    t.float    "int_mod"
    t.float    "wis_mod"
    t.float    "cha_mod"
    t.float    "ele_fw_mod"
    t.float    "ele_ld_mod"
    t.float    "phys_def_mod"
    t.float    "skill_def_mod"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "map_item_invs", :force => true do |t|
    t.integer  "mini_map_id"
    t.integer  "item_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "map_item_invs", ["item_id"], :name => "index_map_item_invs_on_item_id"
  add_index "map_item_invs", ["mini_map_id"], :name => "index_map_item_invs_on_mini_map_id"

  create_table "mini_map_cells", :force => true do |t|
    t.integer  "mini_map_id"
    t.integer  "x"
    t.integer  "y"
    t.integer  "terrain_id"
    t.integer  "sp_resource_id"
    t.integer  "construction_id"
    t.integer  "built_point"
    t.boolean  "active_flg"
    t.boolean  "capital_flg"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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

  create_table "mission_queues", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "squad_id"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "mission_queues", ["mission_id"], :name => "index_mission_queues_on_mission_id"
  add_index "mission_queues", ["squad_id"], :name => "index_mission_queues_on_squad_id"

  create_table "mission_strategies", :force => true do |t|
    t.integer  "houdd_user_id"
    t.string   "name"
    t.text     "script"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mission_strategies", ["houdd_user_id"], :name => "index_mission_strategies_on_houdd_user_id"

  create_table "missions", :force => true do |t|
    t.integer  "houdd_user_id"
    t.integer  "mini_map_id"
    t.string   "category_symbol"
    t.integer  "mission_strategy_id"
    t.string   "status_symbol"
    t.decimal  "start_houdd_time",    :precision => 10, :scale => 3
    t.decimal  "end_houdd_time",      :precision => 10, :scale => 3
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "missions", ["houdd_user_id"], :name => "index_missions_on_houdd_user_id"
  add_index "missions", ["mini_map_id"], :name => "index_missions_on_mini_map_id"
  add_index "missions", ["mission_strategy_id"], :name => "index_missions_on_mission_strategy_id"

  create_table "mobs", :force => true do |t|
    t.integer  "houdd_user_id"
    t.integer  "specie_id"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.integer  "generation"
    t.integer  "job_id"
    t.integer  "squad_id"
    t.string   "name"
    t.string   "gender_sym"
    t.integer  "age"
    t.integer  "hp"
    t.integer  "sp"
    t.integer  "str"
    t.integer  "dex"
    t.integer  "con"
    t.integer  "int"
    t.integer  "wis"
    t.integer  "cha"
    t.integer  "phys_def"
    t.integer  "skill_def"
    t.integer  "ele_fw"
    t.integer  "ele_ld"
    t.boolean  "natural_death_flg"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "mobs", ["houdd_user_id"], :name => "index_mobs_on_houdd_user_id"
  add_index "mobs", ["job_id"], :name => "index_mobs_on_job_id"
  add_index "mobs", ["specie_id"], :name => "index_mobs_on_specie_id"
  add_index "mobs", ["squad_id"], :name => "index_mobs_on_squad_id"

  create_table "production_queues", :force => true do |t|
    t.integer  "houdd_user_id"
    t.string   "symbol"
    t.integer  "queue_id"
    t.integer  "priority"
    t.integer  "allotment"
    t.boolean  "destroy_flg"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "production_queues", ["houdd_user_id"], :name => "index_production_queues_on_houdd_user_id"

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

  create_table "skills", :force => true do |t|
    t.string   "type_symbol"
    t.string   "element_symbol"
    t.string   "name"
    t.integer  "sp_cost"
    t.integer  "num_of_tgt"
    t.integer  "hit_accuracy"
    t.integer  "range"
    t.integer  "damage"
    t.integer  "heal"
    t.float    "str_mod"
    t.float    "dex_mod"
    t.float    "con_mod"
    t.float    "int_mod"
    t.float    "wis_mod"
    t.float    "cha_mod"
    t.float    "ele_fw_mod"
    t.float    "ele_ld_mod"
    t.float    "phys_def_mod"
    t.float    "skill_def_mod"
    t.integer  "duration"
    t.integer  "cast_cycle"
    t.integer  "research_level"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

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

  create_table "specie_job_invs", :force => true do |t|
    t.integer  "specie_id"
    t.integer  "job_id"
    t.integer  "frequency_rate"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "specie_job_invs", ["job_id"], :name => "index_specie_job_invs_on_job_id"
  add_index "specie_job_invs", ["specie_id"], :name => "index_specie_job_invs_on_specie_id"

  create_table "species", :force => true do |t|
    t.integer  "family_id"
    t.string   "name"
    t.integer  "longevity"
    t.float    "prolificacy"
    t.float    "growth_rate"
    t.integer  "food_cost"
    t.integer  "str"
    t.integer  "dex"
    t.integer  "con"
    t.integer  "int"
    t.integer  "wis"
    t.integer  "cha"
    t.float    "mutation_rate"
    t.integer  "phys_def"
    t.integer  "skill_def"
    t.integer  "ele_fw"
    t.integer  "ele_ld"
    t.integer  "skill_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "species", ["family_id"], :name => "index_species_on_family_id"
  add_index "species", ["skill_id"], :name => "index_species_on_skill_id"

  create_table "squads", :force => true do |t|
    t.integer  "houdd_user_id"
    t.integer  "mini_map_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "squads", ["houdd_user_id"], :name => "index_squads_on_houdd_user_id"
  add_index "squads", ["mini_map_id"], :name => "index_squads_on_mini_map_id"

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

  create_table "trial_battle_sets", :force => true do |t|
    t.integer  "trial_move_turn_id"
    t.integer  "attacker_squad_id"
    t.integer  "defender_squad_id"
    t.integer  "distance"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "trial_battle_sets", ["attacker_squad_id"], :name => "index_trial_battle_sets_on_attacker_squad_id"
  add_index "trial_battle_sets", ["defender_squad_id"], :name => "index_trial_battle_sets_on_defender_squad_id"
  add_index "trial_battle_sets", ["trial_move_turn_id"], :name => "index_trial_battle_sets_on_trial_move_turn_id"

  create_table "trial_battle_turns", :force => true do |t|
    t.integer  "trial_battle_set_id"
    t.text     "log"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "trial_battle_turns", ["trial_battle_set_id"], :name => "index_trial_battle_turns_on_trial_battle_set_id"

  create_table "trial_fortress_cells", :force => true do |t|
    t.integer  "trial_id"
    t.string   "symbol"
    t.integer  "x"
    t.integer  "y"
    t.boolean  "trap_flg"
    t.boolean  "goal_flg"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "trial_fortress_cells", ["trial_id"], :name => "index_trial_fortress_cells_on_trial_id"

  create_table "trial_mob_statuses", :force => true do |t|
    t.integer  "trial_battle_turn_id"
    t.integer  "trial_mob_id"
    t.integer  "vpos"
    t.integer  "start_hp"
    t.integer  "end_hp"
    t.integer  "start_sp"
    t.integer  "end_sp"
    t.string   "start_status"
    t.string   "end_status"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "trial_mob_statuses", ["trial_battle_turn_id"], :name => "index_trial_mob_statuses_on_trial_battle_turn_id"
  add_index "trial_mob_statuses", ["trial_mob_id"], :name => "index_trial_mob_statuses_on_trial_mob_id"

  create_table "trial_mobs", :force => true do |t|
    t.integer  "trial_squad_id"
    t.integer  "mob_id"
    t.string   "name"
    t.string   "job_name"
    t.integer  "max_hp"
    t.integer  "max_sp"
    t.integer  "hp"
    t.integer  "sp"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "trial_mobs", ["trial_squad_id"], :name => "index_trial_mobs_on_trial_squad_id"

  create_table "trial_move_turns", :force => true do |t|
    t.integer  "trial_id"
    t.text     "log"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "trial_move_turns", ["trial_id"], :name => "index_trial_move_turns_on_trial_id"

  create_table "trial_squad_trails", :force => true do |t|
    t.integer  "trial_move_turn_id"
    t.integer  "trial_squad_id"
    t.integer  "from_x"
    t.integer  "from_y"
    t.integer  "to_x"
    t.integer  "to_y"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "trial_squad_trails", ["trial_move_turn_id"], :name => "index_trial_squad_trails_on_trial_move_turn_id"
  add_index "trial_squad_trails", ["trial_squad_id"], :name => "index_trial_squad_trails_on_trial_squad_id"

  create_table "trial_squads", :force => true do |t|
    t.integer  "trial_id"
    t.integer  "squad_id"
    t.string   "name"
    t.boolean  "intruder_flg"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "trial_squads", ["trial_id"], :name => "index_trial_squads_on_trial_id"

  create_table "trials", :force => true do |t|
    t.integer  "mini_map_id"
    t.string   "map_name"
    t.integer  "guard_mission_id"
    t.integer  "intruder_mission_id"
    t.integer  "occurred_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "trials", ["mini_map_id"], :name => "index_trials_on_mini_map_id"

end
