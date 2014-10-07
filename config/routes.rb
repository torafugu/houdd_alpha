HouddAlpha::Application.routes.draw do

  resources :species

  resources :item_infos

  resources :skills

  resources :families

  resources :items

  resources :jobs

  resources :trials

  resources :missions

  resources :mission_strategies

  resources :genes

  match '/mobs/:user_id/select_specie' => 'mobs#select_specie'
  match '/mobs/:user_id/:specie_id/index' => 'mobs#index'
  resources :mobs

  resources :specie_job_invs

  resources :dnas

  resources :squads
  resources :job_skill_invs
  resources :specie_skill_invs
  resources :family_skill_invs

  resources :mini_map_cells

  resources :item_sp_resource_invs

  resources :map_item_invs

  resources :item_info_status_mod_invs
  resources :specie_status_mod_invs
  resources :body_part_status_mod_invs

  resources :mini_maps

  resources :mini_map_roads

  resources :researches

  resources :houdd_users

  resources :constructions

  resources :fortress_cells

  # my_page - production_queue
  match '/my_page/:user_id/:queue_id/delete_production_queue' => 'my_page#delete_production_queue', :via => :delete
  match '/my_page/:user_id/update_production_queues' => 'my_page#update_production_queues', :via => :put
  match '/my_page/:user_id/production_queue_index' => 'my_page#production_queue_index'

  # my_page - map
  match '/my_page/:user_id/:mini_map_id/:end_mini_map_id/new_road' => 'my_page#new_road', :via => :post
  match '/my_page/:user_id/:mini_map_id/find_new_root' => 'my_page#find_new_root'
  match '/my_page/:user_id/:mini_map_id/:road_id/delete_road' => 'my_page#delete_road', :via => :delete
  match '/my_page/:user_id/:mini_map_id/:road_id/level_up_road' => 'my_page#level_up_road', :via => :put
  match '/my_page/:user_id/:mini_map_id/road_index' => 'my_page#road_index'
  match '/my_page/:user_id/:mini_map_id/show_mini_map_terrains' => 'my_page#show_mini_map_terrains'
  match '/my_page/:user_id/:mini_map_id/show_mini_map_sp_resources' => 'my_page#show_mini_map_sp_resources'
  match '/my_page/:user_id/:mini_map_id/delete_construction' => 'my_page#delete_construction', :via => :delete
  match '/my_page/:user_id/:mini_map_id/new_construction' => 'my_page#new_construction', :via => :post
  match '/my_page/:user_id/:mini_map_id/render_map_cells' => 'my_page#render_map_cells'
  match '/my_page/:user_id/:mini_map_id/edit_mini_map_constructions' => 'my_page#edit_mini_map_constructions'
  match '/my_page/:user_id/:mini_map_id/edit_fortress_squads' => 'my_page#edit_fortress_squads'
  match '/my_page/:user_id/:mini_map_id/:fortress_x/:fortress_y/select_fortress_cell_squad' => 'my_page#select_fortress_cell_squad'
  match '/my_page/:user_id/:mini_map_id/put_squad' => 'my_page#put_squad', :via => :put
  match '/my_page/:user_id/:mini_map_id/take_squad' => 'my_page#take_squad', :via => :put
  match '/my_page/:user_id/:mini_map_id/edit_fortress_traps' => 'my_page#edit_fortress_traps'
  match '/my_page/:user_id/:mini_map_id/:fortress_x/:fortress_y/select_fortress_cell_trap' => 'my_page#select_fortress_cell_trap'
  match '/my_page/:user_id/:mini_map_id/put_trap' => 'my_page#put_trap', :via => :put
  match '/my_page/:user_id/:mini_map_id/take_trap' => 'my_page#take_trap', :via => :put
  match '/my_page/:user_id/mini_map_index' => 'my_page#mini_map_index'

  # my_page - research
  match '/my_page/:user_id/research_index' => 'my_page#research_index'
  match '/my_page/:user_id/update_researches' => 'my_page#update_researches', :via => :put

  # my_page - item manufacturing
  match '/my_page/:user_id/new_item' => 'my_page#new_item', :via => :post
  match '/my_page/:user_id/:type_symbol/select_item_type' => 'my_page#select_item_type'
  match '/my_page/:user_id/select_product_item' => 'my_page#select_product_item'

  # my_page - item warehouse
  match '/my_page/:user_id/item_warehouse_index' => 'my_page#item_warehouse_index'
  match '/my_page/:user_id/:type_symbol/show_inv_items' => 'my_page#show_inv_items'

  # my_page - mob
  match '/my_page/:user_id/mob_index' => 'my_page#mob_index'
  match '/my_page/:user_id/:family_id/select_specie' => 'my_page#select_specie'
  match '/my_page/:user_id/:specie_id/show_mobs' => 'my_page#show_mobs'
  match '/my_page/:user_id/:mob_id/edit_mob_equips' => 'my_page#edit_mob_equips'
  match '/my_page/:user_id/:mob_id/update_mob_equips' => 'my_page#update_mob_equips', :via => :put

  # my_page - squad
  match '/my_page/:user_id/squad_index' => 'my_page#squad_index'
  match '/my_page/:user_id/new_squad' => 'my_page#new_squad'
  match '/my_page/:user_id/create_squad' => 'my_page#create_squad', :via => :post
  match '/my_page/:user_id/:squad_id/edit_squad' => 'my_page#edit_squad'
  match '/my_page/:user_id/:squad_id/update_squad' => 'my_page#update_squad', :via => :put
  match '/my_page/:user_id/:squad_id/delete_squad' => 'my_page#delete_squad', :via => :delete
  match '/my_page/:user_id/:job_id/select_mobs_to_assign' => 'my_page#select_mobs_to_assign'
  match '/my_page/:user_id/:squad_id/:job_id/select_mobs_to_assign' => 'my_page#select_mobs_to_assign'

  # my_page - mission
  match '/my_page/:user_id/mission_index' => 'my_page#mission_index'
  match '/my_page/:user_id/:mission_completed_flg/mission_index' => 'my_page#mission_index'
  match '/my_page/:user_id/new_mission' => 'my_page#new_mission'
  match '/my_page/:user_id/create_mission' => 'my_page#create_mission', :via => :post
  match '/my_page/:user_id/:mission_id/edit_mission' => 'my_page#edit_mission'
  match '/my_page/:user_id/:mission_id/update_mission' => 'my_page#update_mission', :via => :put
  match '/my_page/:user_id/:mission_id/delete_mission' => 'my_page#delete_mission', :via => :delete
  match '/my_page/:user_id/:mission_id/:trial_id/:turn_index/mission_result' => 'my_page#mission_result'
  match '/my_page/:user_id/:mission_id/:trial_id/:turn_index/:battle_set_index/:battle_turn_index/select_battle_turn' => 'my_page#select_battle_turn'

  # my_page - strategy
  match '/my_page/:user_id/strategy_index' => 'my_page#strategy_index'
  match '/my_page/:user_id/new_strategy' => 'my_page#new_strategy'
  match '/my_page/:user_id/create_strategy' => 'my_page#create_strategy', :via => :post
  match '/my_page/:user_id/:strategy_id/edit_strategy' => 'my_page#edit_strategy'
  match '/my_page/:user_id/:strategy_id/update_strategy' => 'my_page#update_strategy', :via => :put
  match '/my_page/:user_id/:strategy_id/delete_strategy' => 'my_page#delete_strategy', :via => :delete

  # my_page - top
  match '/my_page/:user_id/top' => 'my_page#top'


  # admin_page - map maintenance
  match '/admin_page/mini_map_maintenance' => 'admin_page#mini_map_maintenance'
  match '/admin_page/:mini_map_id/show_fortress_cells' => 'admin_page#show_fortress_cells'
  match '/admin_page/:mini_map_id/generate_fortress_cells' => 'admin_page#generate_fortress_cells', :via => :post
  match '/admin_page/:mini_map_id/:map_mode/update_map_cell' => 'admin_page#update_map_cell', :via => :put
  match '/admin_page/:mini_map_id/:map_mode/render_map_cells' => 'admin_page#render_map_cells'
  match '/admin_page/:mini_map_id/generate_mini_map_cells' => 'admin_page#generate_map_cells', :via => :post
  match '/admin_page/:mini_map_id/edit_mini_map_cells' => 'admin_page#edit_mini_map_cells'
  match '/admin_page/:mini_map_id/:road_id/delete_road' => 'admin_page#delete_road', :via => :delete
  match '/admin_page/:mini_map_id/update_roads' => 'admin_page#update_roads', :via => :put
  match '/admin_page/:mini_map_id/add_row_of_road' => 'admin_page#add_row_of_road'
  match '/admin_page/:mini_map_id/road_index' => 'admin_page#road_index'

  # admin_page - mob maintenance
  match '/admin_page/mob_maintenance' => 'admin_page#mob_maintenance'
  match '/admin_page/:family_id/select_specie' => 'admin_page#select_specie'
  match '/admin_page/:specie_id/edit_mutation_rate' => 'admin_page#edit_mutation_rate'
  match '/admin_page/:specie_id/update_mutation_rate' => 'admin_page#update_mutation_rate', :via => :put
  match '/admin_page/:specie_id/new_seed_mobs' => 'admin_page#new_seed_mobs'
  match '/admin_page/:specie_id/create_seed_mobs' => 'admin_page#create_seed_mobs', :via => :post
  match '/admin_page/:specie_id/assign_new_mobs' => 'admin_page#assign_new_mobs'
  match '/admin_page/:specie_id/assign_mobs' => 'admin_page#assign_mobs', :via => :post
  match '/admin_page/:specie_id/mate_new_mobs' => 'admin_page#mate_new_mobs'
  match '/admin_page/:specie_id/mate_mobs' => 'admin_page#mate_mobs', :via => :post
  match '/admin_page/:specie_id/split_new_mobs' => 'admin_page#split_new_mobs'
  match '/admin_page/:specie_id/split_mobs' => 'admin_page#split_mobs', :via => :post

  # admin_page - data maintenance
  match '/admin_page/data_maintenance' => 'admin_page#data_maintenance'

  # admin_page - queue maintenance
  match '/admin_page/queue_maintenance' => 'admin_page#queue_maintenance'
  match '/admin_page/update_queue' => 'admin_page#update_queue', :via => :put

  # admin_page - top
  match '/admin_page/top' => 'admin_page#top'


  resources :sp_resources
  resources :terrains

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
