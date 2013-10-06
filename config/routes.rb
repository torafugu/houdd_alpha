HouddAlpha::Application.routes.draw do

  resources :status_mods

  resources :jobs

  resources :genes

  resources :mobs

  resources :species

  resources :specie_job_invs

  resources :dnas

  resources :squads

  resources :skill_invs

  resources :families

  resources :skills

  resources :skill_categories

  resources :mini_map_cells

  resources :items

  resources :item_sp_resource_invs

  resources :item_infos

  resources :item_categories

  resources :map_item_invs

  resources :item_info_status_mod_invs
  resources :specie_status_mod_invs
  resources :body_part_status_mod_invs

  resources :status_mod_invs

  resources :body_parts

  resources :mini_maps

  resources :mini_map_roads

  resources :researches

  resources :houdd_users

  resources :constructions

  resources :fortress_cells

  # my_page - production_que
  match '/my_page/:user_id/:que_id/delete_production_que' => 'my_page#delete_production_que', :via => :delete
  match '/my_page/:user_id/update_production_ques' => 'my_page#update_production_ques', :via => :put
  match '/my_page/:user_id/production_que_index' => 'my_page#production_que_index'

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
  match '/my_page/:user_id/mini_map_index' => 'my_page#mini_map_index'

  # my_page - reserach
  match '/my_page/:user_id/research_index' => 'my_page#research_index'
  match '/my_page/:user_id/update_researches' => 'my_page#update_researches', :via => :put

  # my_page - item manufacturing
  match '/my_page/:user_id/new_item' => 'my_page#new_item', :via => :post
  match '/my_page/:user_id/:type_sym/select_item_category' => 'my_page#select_item_category'
  match '/my_page/:user_id/:item_category_id/select_item_info' => 'my_page#select_item_info'
  match '/my_page/:user_id/select_product_item' => 'my_page#select_product_item'

  # my_page - mob
  match '/my_page/:user_id/mob_index' => 'my_page#mob_index'

  # my_page - item warehouse
  match '/my_page/:user_id/item_index' => 'my_page#item_index'

  # my_page - strategy
  match '/my_page/:user_id/strategy_index' => 'my_page#strategy_index'

  # my_page - mission
  match '/my_page/:user_id/mission_index' => 'my_page#mission_index'

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
  match '/admin_page/:specie_id/edit_seed_mobs' => 'admin_page#edit_seed_mobs'
  match '/admin_page/:specie_id/add_seed_mobs' => 'admin_page#add_seed_mobs', :via => :post

  # admin_page - data maintenance
  match '/admin_page/data_maintenance' => 'admin_page#data_maintenance'

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
