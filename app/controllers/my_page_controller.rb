class MyPageController < ApplicationController
  # GET /my_page/1/top
  def top
    respond_to do |format|
      format.html # top.html.erb
    end
  end

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

  # POST /my_page/1/1/new_construction
  def new_construction
    unless params[:update_map_cell]['mapchip_id'].blank?
      mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
      mini_map_cell.construction_id = params[:update_map_cell]['mapchip_id'].to_i
      mini_map_cell.built_point = 0
      mini_map_cell.const_active_flg = false
      production_que = ProductionQue.new
      production_que.houdd_user_id = params[:user_id].to_i
      production_que.symbol = :mini_map_cell.to_s
      production_que.que_id = mini_map_cell.id
      production_que.destroy_flg = false
      production_que.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY
      production_que.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT
    end
    
    respond_to do |format|
      if mini_map_cell.save and production_que.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_page/1/1/delete_construction
  def delete_construction
    mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
    mini_map_cell.const_active_flg = false
    create_production_que = ProductionQue.find_by_symbol_and_que_id_and_destroy_flg(:mini_map_cell.to_s, mini_map_cell.id, false)
    create_production_que.destroy unless create_production_que.blank?

    destroy_production_que = ProductionQue.new
    destroy_production_que.houdd_user_id = params[:user_id].to_i
    destroy_production_que.symbol = :mini_map_cell.to_s
    destroy_production_que.que_id = mini_map_cell.id
    destroy_production_que.destroy_flg = true
    destroy_production_que.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY
    destroy_production_que.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT
    
    respond_to do |format|
      if mini_map_cell.save and destroy_production_que.save
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
    production_que = ProductionQue.new
    production_que.houdd_user_id = params[:user_id].to_i
    production_que.symbol = :mini_map_road.to_s
    production_que.que_id = params[:road_id].to_i
    production_que.destroy_flg = false
    production_que.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY
    production_que.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT
    
    respond_to do |format|
      if production_que.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_page/1/1/1/delete_road
  def delete_road
    create_production_que = ProductionQue.find_by_symbol_and_que_id_and_destroy_flg(:mini_map_road.to_s, params[:road_id], false)
    create_production_que.destroy unless create_production_que.blank?

    mini_map_road = MiniMapRoad.find(params[:road_id])
    mini_map_road.active_flg = false

    destroy_production_que = ProductionQue.new
    destroy_production_que.houdd_user_id = params[:user_id].to_i
    destroy_production_que.symbol = :mini_map_road.to_s
    destroy_production_que.que_id = params[:road_id].to_i
    destroy_production_que.destroy_flg = true
    destroy_production_que.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY
    destroy_production_que.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT
    
    respond_to do |format|
      if mini_map_road.save and destroy_production_que.save
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

    production_que = ProductionQue.new
    production_que.houdd_user_id = params[:user_id].to_i
    production_que.symbol = :mini_map_road.to_s
    production_que.que_id = mini_map_road.id
    production_que.destroy_flg = false
    production_que.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY
    production_que.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT  
    
    respond_to do |format|
      if mini_map_road_save_status and production_que.save
        format.json { head :no_content }
      else
        format.json { render json: 'Save was failed.', status: :unprocessable_entity }
      end
    end
  end

  # GET /my_page/1/production_que_index
  def production_que_index
    @houdd_user = HouddUser.find(params[:user_id])
    allotment_total = ProductionQue.sum(:allotment, :conditions => {:houdd_user_id => params[:user_id]})
    @remaining_production = @houdd_user.productions_total - allotment_total
    @production_ques = ProductionQue.find_all_by_houdd_user_id(params[:user_id], :order => 'priority, allotment')

    respond_to do |format|
      format.html # production_que_index.html.erb
    end
  end

  # PUT /my_page/1/update_production_ques
  def update_production_ques
    @save_success_flg = true
    ProductionQue.transaction do
      for production_que in params[:production_ques]
        unless production_que["id"].blank?
          @production_que = ProductionQue.find(production_que["id"])
          @save_success_flg = @production_que.update_attributes(production_que)
        end

        if @save_success_flg
          allotment_total = ProductionQue.sum(:allotment, :conditions => {:houdd_user_id => params[:user_id]})
          @save_success_flg = false if HouddUser.find(params[:user_id]).productions_total < allotment_total
          @production_que.errors[:base] << I18n.t('activerecord.errors.models.production_que.attributes.allotment_is_greater_than')
        end

        unless @save_success_flg
          respond_to do |format|
            flash[:errors] = @production_que.errors
            format.html { redirect_to action: "production_que_index" }
            format.json { render json: @production_que.errors, status: :created }
          end
          raise ActiveRecord::Rollback
          break
        end
      end
    end

    if @save_success_flg
      respond_to do |format|
        format.html { redirect_to action: "production_que_index" }
        format.json { render json: production_que.errors, status: :unprocessable_entity }
      end
    end
  end
end
