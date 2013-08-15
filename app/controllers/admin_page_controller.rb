class AdminPageController < ApplicationController
  MAP_MODE_TERRAIN = 1
  MAP_MODE_RESOURCE = 2
  MAP_CONSTRUCTION = 3

  # GET /admin_page/top
  def top
    # @construction = Construction.new
    # @constructions = Construction.all

    respond_to do |format|
      format.html # top.html.erb
    end
  end

  # GET /admin_page/data_maintenance
  def data_maintenance
    respond_to do |format|
      format.html # data_maintenance.html.erb
    end
  end

  # GET /admin_page/mini_map_maintenance
  def mini_map_maintenance
    @mini_maps = MiniMap.all

    respond_to do |format|
      format.html # mini_map_maintenance.html.erb
    end
  end

  # GET /admin_page/1/edit_mini_map_cells
  def edit_mini_map_cells
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # edit_mini_map_cells.html.erb
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

  # GET /admin_page/1/road_index
  def road_index
    @mini_map = MiniMap.find(params[:mini_map_id])
    @mini_maps = MiniMap.where("id <> ?", params[:mini_map_id])
    @roads = MiniMapRoad.find_all_by_start_mini_map_id(params[:mini_map_id])

    respond_to do |format|
      format.html # road_index.html.erb
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
        format.json { render json: mini_map_road.errors, status: :unprocessable_entity }
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

  # DELETE /admin_page/1/1/delete_road
  def delete_road
    @mini_map_road = MiniMapRoad.find(params[:road_id])
    @mini_map_road.destroy

    respond_to do |format|
      format.html { redirect_to action: "road_index" }
      format.json { head :no_content }
    end
  end

  # GET /admin_page/1/show_fortress_cells
  def show_fortress_cells
    @mini_map = MiniMap.find(params[:mini_map_id])

    respond_to do |format|
      format.html # show_fortress_cells.html.erb
    end
  end
end
