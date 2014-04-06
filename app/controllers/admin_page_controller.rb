class AdminPageController < ApplicationController
  MAP_MODE_TERRAIN = 1
  MAP_MODE_RESOURCE = 2
  MAP_CONSTRUCTION = 3

  # GET /admin_page/top
  def top
    respond_to do |format|
      format.html # top.html.erb
    end
  end

  # admin_page - map maintenance
  # GET /admin_page/mini_map_maintenance
  def mini_map_maintenance
    @mini_maps = MiniMap.all

    respond_to do |format|
      format.html # mini_map_maintenance.html.erb
    end
  end

  # GET /admin_page/1/show_fortress_cells
  def show_fortress_cells
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # show_fortress_cells.html.erb
    end
  end

  # POST /admin_page/1/generate_fortress_cells
  def generate_fortress_cells

    respond_to do |format|
      if FortressCreator.random_cell(params[:mini_map_id])
        format.json { head :no_content }
      else
        format.json { render json: 'FortressCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin_page/1/1/update_map_cell
  def update_map_cell
    mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
    case params[:map_mode].to_i
    when MAP_MODE_TERRAIN
      mini_map_cell.terrain_id = params[:update_map_cell]['mapchip_id'].to_i
    when MAP_MODE_RESOURCE
      if params[:update_map_cell]['mapchip_id'].blank?
        mini_map_cell.sp_resource_id = nil
      else
        mini_map_cell.sp_resource_id = params[:update_map_cell]['mapchip_id'].to_i
      end
    when MAP_CONSTRUCTION
      if params[:update_map_cell]['mapchip_id'].blank?
        mini_map_cell.construction_id = nil
      else
        mini_map_cell.construction_id = params[:update_map_cell]['mapchip_id'].to_i
        mini_map_cell.built_point = Construction.find(params[:update_map_cell]['mapchip_id'].to_i).rq_prod_point
        mini_map_cell.const_active_flg = true
      end
    end

    respond_to do |format|
      if mini_map_cell.save
        format.json { head :no_content }
      else
        format.json { render json: mini_map_cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/1/render_map_cells
  def render_map_cells
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_map_edit_mode = params[:map_mode]

    respond_to do |format|
      format.js # render_map_cells.js.coffee
    end
  end

  # POST /admin_page/1/generate_map_cells
  def generate_map_cells

    respond_to do |format|
      if MiniMapCreator.random_cell(params[:mini_map_id])
        format.json { head :no_content }
      else
        format.json { render json: 'MiniMapCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/edit_mini_map_cells
  def edit_mini_map_cells
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # edit_mini_map_cells.html.erb
    end
  end

  # DELETE /admin_page/1/1/delete_road
  def delete_road
    @mini_map_road = MiniMapRoad.find(params[:road_id])
    @mini_map_road.destroy

    respond_to do |format|
      format.html { redirect_to action: "road_index" }
      format.json { head :no_content }
    end
  end

  # PUT /admin_page/1/update_roads
  def update_roads
    @save_success_flg = true
    for road in params[:roads]
      unless road["id"].blank?
        @mini_map_road = MiniMapRoad.find(road["id"])
        @mini_map_road.update_attributes(road)
      else
        @mini_map_road = MiniMapRoad.new
        @mini_map_road.assign_attributes(road)
      end
      
      unless @mini_map_road.save
        @save_success_flg = false
        respond_to do |format|
          flash[:errors] = @mini_map_road.errors
          format.html { redirect_to action: "road_index" }
          format.json { render json: @mini_map_road.errors, status: :created }
        end
        break
      end
    end

    if @save_success_flg
      respond_to do |format|
        format.html { redirect_to action: "road_index" }
        format.json { head :no_content }
      end
    end
  end

  # GET PUT /admin_page/1/add_row_of_road
  def add_row_of_road
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_maps = MiniMap.where("id <> ?", params[:mini_map_id])

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # GET /admin_page/1/road_index
  def road_index
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_maps = MiniMap.where("id <> ?", params[:mini_map_id])
    @roads = MiniMapRoad.find_all_by_start_mini_map_id(params[:mini_map_id])

    respond_to do |format|
      format.html # road_index.html.erb
    end
  end

  # admin_page - mob maintenance
  # GET /admin_page/mob_maintenance
  def mob_maintenance
    respond_to do |format|
      format.html # mob_maintenance.html.erb
    end
  end

  # GET /admin_page/1/select_specie
  def select_specie
    @species = Specie.find_all_by_family_id(params[:family_id])

    respond_to do |format|
      format.js # select_specie.js.coffee
    end
  end

  # GET /admin_page/1/1/new_seed_mobs
  def new_seed_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      format.html # new_seed_mobs.html.erb
    end
  end

  # GET /admin_page/1/1/create_seed_mobs
  def create_seed_mobs
    respond_to do |format|
      if MobCreator.seed_mobs(params[:specie_id].to_i, params[:seed_mobs_volume].to_i)
        flash[:success] = 'OK'
        format.html { redirect_to action: "new_seed_mobs" }
        format.json { head :no_content }
      else
        flash[:errors] = 'MobCreator failed.'
        format.html { redirect_to action: "new_seed_mobs" }
        format.json { render json: 'MobCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/1/edit_mutation_rate
  def edit_mutation_rate
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      format.html # edit_mutation_rate.html.erb
    end
  end

  # GET /admin_page/1/1/update_mutation_rate
  def update_mutation_rate
    specie = Specie.find(params[:specie_id])
    specie.mutation_rate = params[:mypage_mutation_rate]

    respond_to do |format|
      if specie.save
        flash[:success] = 'OK'
        format.html { redirect_to action: "edit_mutation_rate" }
        format.json { head :no_content }
      else
        flash[:errors] = 'update_mutation_rate failed.'
        format.html { redirect_to action: "edit_mutation_rate" }
        format.json { render json: 'update_mutation_rate failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/1/assign_new_mobs
  def assign_new_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      format.html # assign_new_mobs.html.erb
    end
  end

  # POST /admin_page/1/1/assign_mobs
  def assign_mobs
    respond_to do |format|
      if MobCreator.assign_new_mobs(params[:new_mobs_volume].to_i, params[:user]['id'].to_i, params[:specie_id].to_i)
        flash[:success] = 'OK'
        format.html { redirect_to action: "assign_new_mobs" }
        format.json { head :no_content }
      else
        flash[:errors] = 'MobCreator failed.'
        format.html { redirect_to action: "assign_new_mobs" }
        format.json { render json: 'MobCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/1/mate_new_mobs
  def mate_new_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      format.html # mate_new_mobs.html.erb
    end
  end

  # POST /admin_page/1/1/mate_mobs
  def mate_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      if not @specie.family.asexual_flg and not MobCreator.specie_able_to_mate?(params[:user]['id'].to_i, @specie.id)
        flash[:validation] = 'Failed'
        format.html { redirect_to action: "mate_new_mobs" }
        format.json { head :no_content }
      elsif MobCreator.random_mate_mob(params[:new_mobs_volume].to_i, params[:user]['id'].to_i, @specie.id)
        flash[:success] = 'OK'
        format.html { redirect_to action: "mate_new_mobs" }
        format.json { head :no_content }
      else
        flash[:errors] = 'MobCreator failed.'
        format.html { redirect_to action: "mate_new_mobs" }
        format.json { render json: 'MobCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /admin_page/1/1/split_new_mobs
  def split_new_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      format.html # split_new_mobs.html.erb
    end
  end

  # POST /admin_page/1/1/split_mobs
  def split_mobs
    @specie = Specie.find(params[:specie_id])

    respond_to do |format|
      if Mob.find_all_by_houdd_user_id_and_specie_id(params[:user]['id'].to_i, @specie.id).blank?
        flash[:validation] = 'Failed'
        format.html { redirect_to action: "split_new_mobs" }
        format.json { head :no_content }
      elsif MobCreator.random_split_mob(params[:new_mobs_volume].to_i, params[:user]['id'].to_i, @specie.id)
        flash[:success] = 'OK'
        format.html { redirect_to action: "split_new_mobs" }
        format.json { head :no_content }
      else
        flash[:errors] = 'MobCreator failed.'
        format.html { redirect_to action: "split_new_mobs" }
        format.json { render json: 'MobCreator failed.', status: :unprocessable_entity }
      end
    end
  end

  # admin_page - queue maintenance
  # GET /admin_page/queue_maintenance
  def queue_maintenance
    respond_to do |format|
      format.html # queue_maintenance.html.erb
    end
  end

  # GET /admin_page/update_queue
  def update_queue
    respond_to do |format|
      if ProductionQueueUpdater.execute(params[:queue_update_times].to_i)
        flash[:success] = 'OK'
        format.html { redirect_to action: "queue_maintenance" }
        format.json { head :no_content }
      else
        flash[:errors] = 'update_queue failed.'
        format.html { redirect_to action: "queue_maintenance" }
        format.json { render json: 'update_queue failed.', status: :unprocessable_entity }
      end
    end
  end

  # admin_page - data maintenance
  # GET /admin_page/data_maintenance
  def data_maintenance
    respond_to do |format|
      format.html # data_maintenance.html.erb
    end
  end
end
