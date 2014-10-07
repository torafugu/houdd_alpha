class MyPageController < ApplicationController

  # GET /my_page/1/top
  def top
    respond_to do |format|
      format.html # top.html.erb
    end
  end


  # my_page - production_queue
  # GET /my_page/1/production_queue_index
  def production_queue_index
    @houdd_user = HouddUser.find(params[:user_id])
    @production_queues = ProductionQueue.find_all_by_houdd_user_id(params[:user_id], :order => 'priority, allotment')

    respond_to do |format|
      format.html # production_queue_index.html.erb
    end
  end

  # PUT /my_page/1/update_production_queues
  def update_production_queues
    @save_success_flg = true
    ProductionQueue.transaction do
      for production_queue in params[:production_queues]
        unless production_queue["id"].blank?
          @production_queue = ProductionQueue.find(production_queue["id"])
          @save_success_flg = @production_queue.update_attributes(production_queue)
        end

        if @save_success_flg
          @save_success_flg = false if HouddUser.find(params[:user_id]).remaining_production_total < 0
          @production_queue.errors[:base] << I18n.t('activerecord.errors.allotment_is_greater_than')
        end

        unless @save_success_flg
          respond_to do |format|
            flash[:errors] = @production_queue.errors
            format.html { redirect_to action: "production_queue_index" }
          end
          raise ActiveRecord::Rollback
          break
        end
      end
    end

    if @save_success_flg
      respond_to do |format|
        flash[:success] = 'OK'
        format.html { redirect_to action: "production_queue_index" }
      end
    end
  end

  # DELETE /my_page/1/1/delete_production_queue
  def delete_production_queue
    create_production_queue = ProductionQueue.find(params[:queue_id])

    destroy_production_queue = ProductionQueue.new
    destroy_production_queue.houdd_user_id = create_production_queue.houdd_user_id
    destroy_production_queue.symbol = create_production_queue.symbol
    destroy_production_queue.queue_id = create_production_queue.queue_id
    destroy_production_queue.destroy_flg = true
    
    respond_to do |format|
      if create_production_queue.destroy and destroy_production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # my_page - map
  # GET /my_page/1/mini_map_index
  def mini_map_index
    @mini_maps = MiniMap.find_all_by_houdd_user_id(params[:user_id])

    respond_to do |format|
      format.html # mini_map_index.html.erb
    end
  end

  # GET /my_page/1/1/show_mini_map_sp_resources
  def show_mini_map_sp_resources
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # show_mini_map_sp_resources.html.erb
    end
  end

  # GET /my_page/1/1/show_mini_map_terrains
  def show_mini_map_terrains
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # show_mini_map_terrains.html.erb
    end
  end

  # GET /my_page/1/1/edit_mini_map_constructions
  def edit_mini_map_constructions
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # edit_mini_map_constructions.html.erb
    end
  end

  # GET /my_page/1/1/render_map_cells
  def render_map_cells
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_map_edit_mode = params[:map_mode]

    respond_to do |format|
      format.js # render_map_cells.js.coffee
    end
  end

  # GET /my_page/1/1/edit_fortress_squads
  def edit_fortress_squads
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mission = Mission.find_by_mini_map_id_and_category_symbol_and_status_symbol(@mini_map.id, :guard.to_s, :on_going.to_s)
    @assignable_squads = MissionQueue.find_all_by_mission_id_and_priority(@mission.id, 1).collect{|l| [l.squad.name, l.squad.id]} unless @mission.blank?

    respond_to do |format|
      format.html # edit_fortress_squads.html.erb
    end
  end

  # GET /my_page/1/1/1/1/select_fortress_cell_squad
  def select_fortress_cell_squad
    @fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:fortress_x], params[:fortress_y])

    respond_to do |format|
      format.js # select_fortress_cell_squad.js.coffee
    end
  end

  # PUT /my_page/1/1/put_squad
  def put_squad
    squad_id = params[:update_fortress_cell]['squad_id']
    FortressCell.update_all('squad_id = null', ['squad_id = ?', squad_id])
    fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_fortress_cell]['put_x'], params[:update_fortress_cell]['put_y'])
    fortress_cell.squad_id = squad_id

    respond_to do |format|
      if fortress_cell.save
        flash[:success] = 'OK'
      else
        flash[:errors] = fortress_cell.errors
      end
      format.html { redirect_to action: "edit_fortress_squads" }
    end
  end

  # PUT /my_page/1/1/take_squad
  def take_squad
    fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_fortress_cell]['take_x'], params[:update_fortress_cell]['take_y'])
    fortress_cell.squad_id = nil

    respond_to do |format|
      if fortress_cell.save
        flash[:success] = 'OK'
      else
        flash[:errors] = fortress_cell.errors
      end
      format.html { redirect_to action: "edit_fortress_squads" }
    end
  end

  # GET /my_page/1/1/edit_fortress_traps
  def edit_fortress_traps
    @mini_map = MiniMap.find(params[:mini_map_id])
    @all_traps = Item.joins(:item_info).where(['item_infos.type_symbol = ? and houdd_user_id = ?',:trap.to_s ,params[:user_id]]).collect{|t| [t.name, t.id]}
    @installed_traps = FortressCell.joins(:mini_map).where(['mini_maps.houdd_user_id = ? and trap_id is not null', params[:user_id]]).collect{|t| [t.trap.name, t.trap_id]}
    @stocked_traps = @all_traps - @installed_traps

    respond_to do |format|
      format.html # edit_fortress_traps.html.erb
    end
  end

    # GET /my_page/1/1/1/1/select_fortress_cell_trap
  def select_fortress_cell_trap
    @fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:fortress_x], params[:fortress_y])

    respond_to do |format|
      format.js # select_fortress_cell_trap.js.coffee
    end
  end

    # PUT /my_page/1/1/put_trap
  def put_trap
    trap_id = params[:update_fortress_cell]['trap_id']
    FortressCell.update_all('trap_id = null', ['trap_id = ?', trap_id])
    fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_fortress_cell]['put_x'], params[:update_fortress_cell]['put_y'])
    fortress_cell.trap_id = trap_id

    respond_to do |format|
      if fortress_cell.save
        flash[:success] = 'OK'
      else
        flash[:errors] = fortress_cell.errors
      end
      format.html { redirect_to action: "edit_fortress_traps" }
    end
  end

  # PUT /my_page/1/1/take_trap
  def take_trap
    fortress_cell = FortressCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_fortress_cell]['take_x'], params[:update_fortress_cell]['take_y'])
    fortress_cell.trap_id = nil

    respond_to do |format|
      if fortress_cell.save
        flash[:success] = 'OK'
      else
        flash[:errors] = fortress_cell.errors
      end
      format.html { redirect_to action: "edit_fortress_traps" }
    end
  end

  # POST /my_page/1/1/new_construction
  def new_construction
    unless params[:update_map_cell]['mapchip_id'].blank?
      mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
      mini_map_cell.construction_id = params[:update_map_cell]['mapchip_id'].to_i
      mini_map_cell.built_point = 0
      mini_map_cell.active_flg = false
      production_queue = ProductionQueue.new
      production_queue.houdd_user_id = params[:user_id].to_i
      production_queue.symbol = :mini_map_cell.to_s
      production_queue.queue_id = mini_map_cell.id
      production_queue.destroy_flg = false
    end
    
    respond_to do |format|
      if mini_map_cell.save and production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_page/1/1/delete_construction
  def delete_construction
    mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
    create_production_queue = ProductionQueue.find_by_symbol_and_queue_id_and_destroy_flg(:mini_map_cell.to_s, mini_map_cell.id, false)
    create_production_queue_destroy_flg = true
    unless create_production_queue.blank?
      create_production_queue_destroy_flg = create_production_queue.destroy
    end

    destroy_production_queue = ProductionQueue.new
    destroy_production_queue.houdd_user_id = params[:user_id].to_i
    destroy_production_queue.symbol = :mini_map_cell.to_s
    destroy_production_queue.queue_id = mini_map_cell.id
    destroy_production_queue.destroy_flg = true
    
    respond_to do |format|
      if create_production_queue_destroy_flg and destroy_production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /my_page/1/1/road_index
  def road_index
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_maps = MiniMap.where("id <> ?", params[:mini_map_id])
    @roads = MiniMapRoad.find_all_by_start_mini_map_id(params[:mini_map_id])

    respond_to do |format|
      format.html # road_index.html.erb
    end
  end

  # PUT /my_page/1/1/1/level_up_road
  def level_up_road
    production_queue = ProductionQueue.new
    production_queue.houdd_user_id = params[:user_id].to_i
    production_queue.symbol = :mini_map_road.to_s
    production_queue.queue_id = params[:road_id].to_i
    production_queue.destroy_flg = false
    
    respond_to do |format|
      if production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_page/1/1/1/delete_road
  def delete_road
    create_production_queue = ProductionQueue.find_by_symbol_and_queue_id_and_destroy_flg(:mini_map_road.to_s, params[:road_id], false)
    create_production_queue_destroy_flg = true
    unless create_production_queue.blank?
      create_production_queue_destroy_flg = create_production_queue.destroy
    end

    destroy_production_queue = ProductionQueue.new
    destroy_production_queue.houdd_user_id = params[:user_id].to_i
    destroy_production_queue.symbol = :mini_map_road.to_s
    destroy_production_queue.queue_id = params[:road_id].to_i
    destroy_production_queue.destroy_flg = true
    
    respond_to do |format|
      if create_production_queue_destroy_flg and destroy_production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /my_page/1/1/find_new_root
  def find_new_root
    mini_map = MiniMap.find(params[:mini_map_id])
    @end_mini_map_id = mini_map.find_new_road
    mini_map.find_root_flg = true
    mini_map.save

    respond_to do |format|
      format.js # find_new_root.js.coffee
    end
  end

  # POST /my_page/1/1/1/new_road
  def new_road
    mini_map_road = MiniMapRoad.new
    mini_map_road.start_mini_map_id = params[:mini_map_id].to_i
    mini_map_road.end_mini_map_id = params[:end_mini_map_id].to_i
    mini_map_road.level = 1
    mini_map_road.built_point = 0
    mini_map_road.active_flg = false
    mini_map_road_save_status = mini_map_road.save

    production_queue = ProductionQueue.new
    production_queue.houdd_user_id = params[:user_id].to_i
    production_queue.symbol = :mini_map_road.to_s
    production_queue.queue_id = mini_map_road.id
    production_queue.destroy_flg = false 
    
    respond_to do |format|
      if mini_map_road_save_status and production_queue.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end


  # my_page - reserach
  # GET /my_page/1/research_index
  def research_index
    @houdd_user = HouddUser.find(params[:user_id])
    @researches = HouddUser.find(params[:user_id]).researches

    respond_to do |format|
      format.html # research_index.html.erb
    end
  end

  # PUT /my_page/1/update_researches
  def update_researches
    @save_success_flg = true
    Research.transaction do
      for research in params[:researches]
        unless research["id"].blank?
          @research = Research.find(research["id"])
          @save_success_flg = @research.update_attributes(research)
        end

        if @save_success_flg
          @save_success_flg = false if HouddUser.find(params[:user_id]).remaining_production_total < 0
          @research.errors[:base] << I18n.t('activerecord.errors.allotment_is_greater_than')
        end

        unless @save_success_flg
          respond_to do |format|
            flash[:errors] = @research.errors
            format.html { redirect_to action: "research_index" }
            format.json { render json: @research.errors, status: :created }
          end
          raise ActiveRecord::Rollback
          break
        end
      end
    end

    if @save_success_flg
      respond_to do |format|
        flash[:success] = 'OK'
        format.html { redirect_to action: "research_index" }
      end
    end
  end

  # my_page - item manufacturing
  # GET /my_page/1/select_product_item
  def select_product_item
    @houdd_user = HouddUser.find(params[:user_id])

    respond_to do |format|
      format.html # select_product_item.html.erb
    end
  end

  # GET /my_page/1/1/select_item_type
  def select_item_type
    houdd_user = HouddUser.find(params[:user_id])
    research = Research.find_by_houdd_user_id_and_symbol(houdd_user.id, params[:type_symbol])
    @item_infos = Array.new
    all_item_infos = ItemInfo.where(["type_symbol = ? and research_level <= ?", params[:type_symbol], research.level])
    all_item_infos.each do |item_info|
      @item_infos << item_info if item_info.rq_sp_resources_all.blank? or houdd_user.available_sp_resources?(item_info.rq_sp_resources_all)
    end

    respond_to do |format|
      format.js # select_item_type.js.coffee
    end
  end

  # POST /my_page/1/new_item
  def new_item
    @save_success_flg = true
    ProductionQueue.transaction do
      for product_item in params[:mypage]
        if product_item["production_volume"] =~ /^\d+$/
          product_item["production_volume"].to_i.times do
            item = Item.new
            item.item_info_id = product_item["item_info_id"].to_i
            item.houdd_user_id = params[:user_id].to_i
            item.active_flg = false
            item.dp = item.item_info.max_dp
            item_save_status = item.save
            production_queue = ProductionQueue.new
            production_queue.houdd_user_id = params[:user_id].to_i
            production_queue.symbol = :item.to_s
            production_queue.queue_id = item.id
            production_queue.destroy_flg = false

            if not item_save_status or not production_queue.save
              @save_success_flg = false
              errors = nil
              respond_to do |format|
                if not item_save_status
                  errors = item.errors
                else
                  errors = production_queue.errors
                end
                flash[:errors] = errors
                format.html { redirect_to action: "select_product_item" }
                format.json { render json: errors, status: :created }
              end
              raise ActiveRecord::Rollback
            end
          end
        end
      end
    end
    
    if @save_success_flg
      respond_to do |format|
        flash[:success] = 'OK'
        format.html { redirect_to action: "select_product_item" }
      end
    end
  end


  # my_page - item warehouse
  # GET /my_page/1/item_warehouse_index
  def item_warehouse_index
    @houdd_user = HouddUser.find(params[:user_id])

    respond_to do |format|
      format.html # item_warehouse_index.html.erb
    end
  end

  # GET /my_page/1/1/show_inv_items
  def show_inv_items
    @inv_items = Item.includes(:item_info).where(["item_infos.type_symbol = ?", params[:type_symbol].to_s])

    respond_to do |format|
      format.js # show_inv_items.js.coffee
    end
  end

  # my_page - mobs
  # GET /my_page/1/mob_index
  def mob_index
    @houdd_user = HouddUser.find(params[:user_id])

    respond_to do |format|
      format.html # mob_index.html.erb
    end
  end

  # GET /my_page/1/1/select_specie
  def select_specie
    @species = Specie.find_all_by_family_id(params[:family_id]).collect{|m| [m.name, m.id]}.insert(0, "")

    respond_to do |format|
      format.js # select_specie.js.coffee
    end
  end

  # GET /my_page/1/1/show_mobs
  def show_mobs
    @mobs = Mob.find_all_by_houdd_user_id_and_specie_id(params[:user_id], params[:specie_id])

    respond_to do |format|
      format.js # show_mobs.js.coffee
    end
  end

  # GET /my_page/1/1/edit_mob_equips
  def edit_mob_equips
    @mob = Mob.find(params[:mob_id])
    @weapon_id = @mob.weapon.id unless @mob.weapon.blank?
    @armor_id = @mob.armor.id unless @mob.armor.blank?

    respond_to do |format|
      format.html # edit_mob_equips.html.erb
    end
  end

  # PUT /my_page/1/1/update_mob_equips
  def update_mob_equips
    @houdd_user = HouddUser.find(params[:user_id])

    @errors = nil
    unless params[:my_page]['weapon_id'].blank?
      weapon_item = Item.find(params[:my_page]['weapon_id'])
      weapon_item.mob_id = params[:mob_id]
      if weapon_item.save
        @errors = weapon_item.errors
      end
    end

    if not params[:my_page]['armor_id'].blank? and @errors.blank?
      armor_item = Item.find(params[:my_page]['armor_id'])
      armor_item.mob_id = params[:mob_id]
      if armor_item.save
        @errors = armor_item.errors
      end
    end

    respond_to do |format|
      unless @errors.blank?
        flash[:errors] = @errors
        format.html { redirect_to action: "mob_index" }
      else
        format.html { redirect_to action: "mob_index" }
        flash[:success] = 'OK'
      end
    end  
  end

  # my_page - squad
  # GET /my_page/1/squad_index
  def squad_index
    @houdd_user = HouddUser.find(params[:user_id])

    respond_to do |format|
      format.html # squad_index.html.erb
    end
  end

  # GET /my_page/1/new_squad
  def new_squad
    @houdd_user = HouddUser.find(params[:user_id])
    @squad = Squad.new
    @squad_index_url = "squad_index"
    @free_mobs = Array.new
    @assigned_mobs = Array.new

    respond_to do |format|
      format.html # new_squad.html.erb
    end
  end

  # GET /my_page/1/1/edit_squad
  def edit_squad
    @houdd_user = HouddUser.find(params[:user_id])
    @squad = Squad.find(params[:squad_id])
    @squad_index_url = "/my_page/" + @squad.houdd_user_id.to_s + "/squad_index"
    @free_mobs = Array.new
    @assigned_mobs = Mob.find_all_by_squad_id(params[:squad_id]).collect{|l| [l.name, l.id]}

    respond_to do |format|
      format.html # edit_squad.html.erb
    end
  end

  # GET /my_page/1/1/select_mobs_to_assign
  def select_mobs_to_assign
    @free_mobs = Mob.find_all_by_houdd_user_id_and_job_id_and_squad_id(params[:user_id], params[:job_id], nil).collect{|l| [l.name, l.id]}

    respond_to do |format|
      format.js # select_mobs_to_assign.js.coffee
    end
  end

  # POST /my_page/1/create_squad
  def create_squad
    squad = Squad.new
    squad.houdd_user_id = params[:user_id]
    squad.name = params[:mypage_squad_name]
    squad.mini_map_id = params[:my_page]['mini_map_id']

    unless squad.save
      respond_to do |format|
        flash[:errors] = squad.errors
        format.html { redirect_to action: "new_squad" }
      end
      return
    end

    assigned_mobs = params[:my_page]['assigned_mobs']
    assigned_mobs.each do |mob_id|
      unless mob_id.blank?
        mob = Mob.find(mob_id)
        mob.squad_id = squad.id
        unless mob.save
          respond_to do |format|
            flash[:errors] = mob.errors
            format.html { redirect_to action: "new_squad" }
          end
          raise ActiveRecord::Rollback
          return
        end
      end
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "squad_index" }
    end
  end

  # PUT /my_page/1/1/update_squad
  def update_squad
    squad = Squad.find(params[:squad_id])
    squad.name = params[:mypage_squad_name]
    squad.mini_map_id = params[:my_page]['mini_map_id']

    unless squad.save
      respond_to do |format|
        flash[:errors] = squad.errors
        format.html { redirect_to action: "edit_squad" }
      end
      return
    end

    squad.mobs.each do |mob|
      mob.squad_id = nil
      unless mob.save
        respond_to do |format|
          flash[:errors] = mob.errors
          format.html { redirect_to action: "edit_squad" }
        end
        raise ActiveRecord::Rollback
      end
    end

    assigned_mobs = params[:my_page]['assigned_mobs']
    assigned_mobs.each do |mob_id|
      unless mob_id.blank?
        mob = Mob.find(mob_id)
        mob.squad_id = squad.id
        unless mob.save
          respond_to do |format|
            flash[:errors] = mob.errors
            format.html { redirect_to action: "edit_squad" }
          end
          raise ActiveRecord::Rollback
        end
      end
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "squad_index" }
    end
  end

  # DELETE /my_page/1/1/delete_squad
  def delete_squad
    @squad = Squad.find(params[:squad_id])
    @squad.mobs.each do |mob|
      mob.squad_id = nil
      mob.save
    end
    @squad.mission_queues.each do |mission_queue|
      mission_queue.destroy
    end
    @squad.destroy
    
    respond_to do |format|
      if @squad.errors.blank?
        flash[:success] = 'OK'
      else
        flash[:errors] = @squad.errors
      end
      format.html { redirect_to action: "squad_index" }
    end
  end

  # my_page - mission
  # GET /my_page/1/mission_index
  def mission_index
    @houdd_user = HouddUser.find(params[:user_id])
    @not_completed_flg = false
    @completed_flg = false

    if params[:mission_completed_flg] == '0'
      @missions = Mission.all(:conditions => ["houdd_user_id = ? and status_symbol <> 'completed'", params[:user_id]])
      @not_completed_flg = true
    elsif params[:mission_completed_flg] == '1'
      @missions = Mission.all(:conditions => ["houdd_user_id = ? and status_symbol = 'completed'", params[:user_id]])
      @completed_flg = true
    else
      @missions = @houdd_user.missions
    end

    respond_to do |format|
      format.html # mission_index.html.erb
    end
  end

  # GET /my_page/1/new_mission
  def new_mission
    @houdd_user = HouddUser.find(params[:user_id])
    @mission = Mission.new
    @mission_index_url = "mission_index"
    @free_squads = Squad.find_all_by_houdd_user_id(params[:user_id]).collect{|l| [l.name, l.id]}
    @assigned_squads = Array.new

    respond_to do |format|
      format.html # new_mission.html.erb
    end
  end

  # GET /my_page/1/1/edit_mission
  def edit_mission
    @houdd_user = HouddUser.find(params[:user_id])
    @mission = Mission.find(params[:mission_id])
    @mission_index_url = "/my_page/" + @houdd_user.id.to_s + "/mission_index"
    @assigned_squads = Squad.all(:include => :missions, :conditions => ["missions.id = ?", params[:mission_id]]).collect{|l| [l.name, l.id]}
    @free_squads = Squad.find_all_by_houdd_user_id(params[:user_id]).collect{|l| [l.name, l.id]} - @assigned_squads
    
    respond_to do |format|
      format.html # edit_mission.html.erb
    end
  end

  # POST /my_page/1/create_mission
  def create_mission
    mission = Mission.new
    mission.houdd_user_id = params[:user_id]
    mission.mini_map_id = params[:my_page]['mini_map_id']
    mission.category_symbol = params[:my_page]['category_symbol']
    mission.status_symbol = :not_start.to_s
    mission.mission_strategy_id = params[:my_page]['mission_strategy_id']
    mission.start_houdd_time = params[:mypage_start_houdd_time]
    mission.end_houdd_time = params[:mypage_end_houdd_time]

    unless mission.save
      respond_to do |format|
        flash[:errors] = mission.errors
        format.html { redirect_to action: "new_mission" }
      end
      return
    end

    assigned_squads = params[:my_page]['assigned_squads']
    assigned_squads.each do |squad_id|
      unless squad_id.blank?
        mission_queue = MissionQueue.new
        mission_queue.mission_id = mission.id
        mission_queue.squad_id = squad_id
        mission_queue.priority = 1
        unless mission_queue.save
          respond_to do |format|
            flash[:errors] = mission_queue.errors
            format.html { redirect_to action: "new_mission" }
          end
          raise ActiveRecord::Rollback
          break
        end
      end
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "mission_index" }
    end
  end

  # PUT /my_page/1/1/update_mission
  def update_mission
    mission = Mission.find(params[:mission_id])
    mission.houdd_user_id = params[:user_id]
    mission.mini_map_id = params[:my_page]['mini_map_id']
    mission.category_symbol = params[:my_page]['category_symbol']
    mission.status_symbol = :not_start.to_s
    mission.mission_strategy_id = params[:my_page]['mission_strategy_id']
    mission.start_houdd_time = params[:mypage_start_houdd_time]
    mission.end_houdd_time = params[:mypage_end_houdd_time]

    unless mission.save
      respond_to do |format|
        flash[:errors] = mission.errors
        format.html { redirect_to action: "edit_mission" }
      end
      return
    end

    unless MissionQueue.destroy_all(:mission_id => params[:mission_id])
      respond_to do |format|
        flash[:errors] = MissionQueue.errors
        format.html { redirect_to action: "edit_mission" }
      end
      raise ActiveRecord::Rollback
      return
    end

    assigned_squads = params[:my_page]['assigned_squads']
    assigned_squads.each do |squad_id|
      unless squad_id.blank?
        mission_queue = MissionQueue.new
        mission_queue.mission_id = mission.id
        mission_queue.squad_id = squad_id
        mission_queue.priority = 1
        unless mission_queue.save
          respond_to do |format|
            flash[:errors] = mission_queue.errors
            format.html { redirect_to action: "edit_mission" }
          end
          raise ActiveRecord::Rollback
          break
        end
      end
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "mission_index" }
    end
  end

  # DELETE /my_page/1/1/delete_mission
  def delete_mission
    @mission = Mission.find(params[:mission_id])
    @mission.mission_queues.each do |mission_queue|
      mission_queue.destroy
    end
    @mission.destroy
    
    respond_to do |format|
      if @mission.errors.blank?
        flash[:success] = 'OK'
      else
        flash[:errors] = @mission.errors
      end
      format.html { redirect_to action: "mission_index" }
    end
  end

  # GET /my_page/1/1/1/1/mission_result
  def mission_result
    @houdd_user = HouddUser.find(params[:user_id])
    @mission = Mission.find(params[:mission_id])
    @trial = Trial.find(params[:trial_id])
    @trial_move_turn_index = params[:turn_index].to_i - 1
    @trial_move_turn_index = 0 if @trial_move_turn_index < 0
    @current_trial_move_turn = @trial.trial_move_turns[@trial_move_turn_index]
    # To see from the index as 1 on view.
    @trial_move_turn_index += 1

    if @trial_move_turn_index == 1
      @trial.initialize_trial_squads_status
    end

    if @current_trial_move_turn.trial_battle_sets.blank?
      @max_battle_set_index = 0
      @first_battle_set_index = 0
      @first_battle_set = nil
      @max_battle_turn_index = 0
      @first_battle_turn_index = 0
      @attacker_squad_name = nil
      @defender_squad_name = nil
      @battle_distance = 0
      @current_battle_turn = nil
    else
      @max_battle_set_index = @current_trial_move_turn.trial_battle_sets.size
      @first_battle_set_index = 1
      @first_battle_set = @current_trial_move_turn.trial_battle_sets.first
      @max_battle_turn_index = @first_battle_set.trial_battle_turns.size
      @first_battle_turn_index = 1
      @attacker_squad_name = @first_battle_set.attacker_squad.name
      @defender_squad_name = @first_battle_set.defender_squad.name
      @battle_distance = @first_battle_set.distance
      @current_battle_turn = @first_battle_set.trial_battle_turns.first
      @trial.update_trial_squads_status(@current_trial_move_turn.id)
    end

    respond_to do |format|
      format.html # mission_result.html.erb
    end
  end

  # GET /my_page/1/1/1/1/1/1/select_battle_turn
  def select_battle_turn
    trial = Trial.find(params[:trial_id])
    trial_move_turn_index = params[:turn_index].to_i - 1
    trial_move_turn_index = 0 if trial_move_turn_index < 0
    current_trial_move_turn = TrialMoveTurn.where("trial_id = ?", trial.id)[trial_move_turn_index]
    @battle_set_index = params[:battle_set_index].to_i - 1
    @battle_set_index = 0 if @battle_set_index < 0
    @current_battle_set = TrialBattleSet.where("trial_move_turn_id = ?", current_trial_move_turn.id)[@battle_set_index]
    @battle_turn_index = params[:battle_turn_index].to_i - 1
    @battle_turn_index = 0 if @battle_turn_index < 0
    @current_battle_turn = TrialBattleTurn.where("trial_battle_set_id = ?", @current_battle_set.id)[@battle_turn_index]
    # To see from the index as 1 on view.
    @battle_set_index += 1
    @battle_turn_index += 1

    respond_to do |format|
      format.js # select_battle_turn.js
    end
  end

  # my_page - strategy
  # GET /my_page/1/strategy_index
  def strategy_index
    @houdd_user = HouddUser.find(params[:user_id])

    respond_to do |format|
      format.html # strategy_index.html.erb
    end
  end

  # GET /my_page/1/new_strategy
  def new_strategy
    @houdd_user = HouddUser.find(params[:user_id])
    @strategy = MissionStrategy.new
    @strategy_index_url = "strategy_index"

    respond_to do |format|
      format.html # new_strategy.html.erb
    end
  end

  # GET /my_page/1/1/edit_strategy
  def edit_strategy
    @houdd_user = HouddUser.find(params[:user_id])
    @strategy = MissionStrategy.find(params[:strategy_id])
    @strategy_index_url = "/my_page/" + @houdd_user.id.to_s + "/strategy_index"

    respond_to do |format|
      format.html # edit_strategy.html.erb
    end
  end

  # POST /my_page/1/create_strategy
  def create_strategy
    strategy = MissionStrategy.new
    strategy.houdd_user_id = params[:user_id]
    strategy.name = params[:mypage]['name']
    strategy.script = params[:mypage]['script']

    unless strategy.save
      respond_to do |format|
        flash[:errors] = strategy.errors
        format.html { redirect_to action: "new_strategy" }
      end
      return
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "strategy_index" }
    end
  end

  # PUT /my_page/1/1/update_strategy
  def update_strategy
    strategy = MissionStrategy.find(params[:strategy_id])
    strategy.houdd_user_id = params[:user_id]
    strategy.name = params[:mypage]['name']
    strategy.script = params[:mypage]['script']

    unless strategy.save
      respond_to do |format|
        flash[:errors] = strategy.errors
        format.html { redirect_to action: "edit_strategy" }
      end
      return
    end

    respond_to do |format|
      flash[:success] = 'OK'
      format.html { redirect_to action: "strategy_index" }
    end
  end

  # DELETE /my_page/1/1/delete_strategy
  def delete_strategy
    strategy = MissionStrategy.find(params[:strategy_id])
    strategy.destroy
    
    respond_to do |format|
      if strategy.errors.blank?
        flash[:success] = 'OK'
      else
        flash[:errors] = strategy.errors
      end
      format.html { redirect_to action: "strategy_index" }
    end
  end
end
