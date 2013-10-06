class MyPageController < ApplicationController
  # GET /my_page/1/top
  def top
    respond_to do |format|
      format.html # top.html.erb
    end
  end

  # my_page - production_que
  # GET /my_page/1/production_que_index
  def production_que_index
    @houdd_user = HouddUser.find(params[:user_id])
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
          @save_success_flg = false if HouddUser.find(params[:user_id]).remaining_production_total < 0
          @production_que.errors[:base] << I18n.t('activerecord.errors.allotment_is_greater_than')
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
        flash[:success] = 'OK'
        format.html { redirect_to action: "production_que_index" }
      end
    end
  end

  # DELETE /my_page/1/1/delete_production_que
  def delete_production_que
    create_production_que = ProductionQue.find(params[:que_id])

    destroy_production_que = ProductionQue.new
    destroy_production_que.houdd_user_id = create_production_que.houdd_user_id
    destroy_production_que.symbol = create_production_que.symbol
    destroy_production_que.que_id = create_production_que.que_id
    destroy_production_que.destroy_flg = true
    
    respond_to do |format|
      if create_production_que.destroy and destroy_production_que.save
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

  # POST /my_page/1/1/new_construction
  def new_construction
    unless params[:update_map_cell]['mapchip_id'].blank?
      mini_map_cell = MiniMapCell.find_by_mini_map_id_and_x_and_y(params[:mini_map_id], params[:update_map_cell]['x'], params[:update_map_cell]['y'])
      mini_map_cell.construction_id = params[:update_map_cell]['mapchip_id'].to_i
      mini_map_cell.built_point = 0
      mini_map_cell.active_flg = false
      production_que = ProductionQue.new
      production_que.houdd_user_id = params[:user_id].to_i
      production_que.symbol = :mini_map_cell.to_s
      production_que.que_id = mini_map_cell.id
      production_que.destroy_flg = false
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
    create_production_que = ProductionQue.find_by_symbol_and_que_id_and_destroy_flg(:mini_map_cell.to_s, mini_map_cell.id, false)
    create_production_que_destroy_flg = true
    unless create_production_que.blank?
      create_production_que_destroy_flg = create_production_que.destroy
    end

    destroy_production_que = ProductionQue.new
    destroy_production_que.houdd_user_id = params[:user_id].to_i
    destroy_production_que.symbol = :mini_map_cell.to_s
    destroy_production_que.que_id = mini_map_cell.id
    destroy_production_que.destroy_flg = true
    
    respond_to do |format|
      if create_production_que_destroy_flg and destroy_production_que.save
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
    create_production_que_destroy_flg = true
    unless create_production_que.blank?
      create_production_que_destroy_flg = create_production_que.destroy
    end

    destroy_production_que = ProductionQue.new
    destroy_production_que.houdd_user_id = params[:user_id].to_i
    destroy_production_que.symbol = :mini_map_road.to_s
    destroy_production_que.que_id = params[:road_id].to_i
    destroy_production_que.destroy_flg = true
    
    respond_to do |format|
      if create_production_que_destroy_flg and destroy_production_que.save
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
    
    respond_to do |format|
      if mini_map_road_save_status and production_que.save
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

  # GET /my_page/1/1/select_item_category
  def select_item_category
    @item_categories = ItemCategory.find_all_by_type_sym(params[:type_sym]).collect{|m| [m.name, m.id]}.insert(0, "")

    respond_to do |format|
      format.js # select_item_category.js.coffee
    end
  end

  # GET /my_page/1/1/select_item_info
  def select_item_info
    houdd_user = HouddUser.find(params[:user_id])
    item_category = ItemCategory.find(params[:item_category_id])
    research = Research.find_by_houdd_user_id_and_symbol(houdd_user.id, item_category.type_sym)
    @item_infos = Array.new
    all_item_infos = ItemInfo.find_all_by_item_category_id(item_category.id, :conditions => ["research_level <= ?", research.level])
    all_item_infos.each do |item_info|
      @item_infos << item_info if item_info.rq_sp_resources_all.blank? or houdd_user.available_sp_resources?(item_info.rq_sp_resources_all)
    end

    respond_to do |format|
      format.js # select_item_info.js.coffee
    end
  end

  # POST /my_page/1/new_item
  def new_item
    @save_success_flg = true
    ProductionQue.transaction do
      for product_item in params[:mypage]
        if product_item["production_volume"] =~ /^\d+$/
          product_item["production_volume"].to_i.times do
            item = Item.new
            item.item_info_id = product_item["item_info_id"].to_i
            item.houdd_user_id = params[:user_id].to_i
            item.active_flg = false
            item_save_status = item.save
            production_que = ProductionQue.new
            production_que.houdd_user_id = params[:user_id].to_i
            production_que.symbol = :item.to_s
            production_que.que_id = item.id
            production_que.destroy_flg = false

            if not item_save_status or not production_que.save
              @save_success_flg = false
              errors = nil
              respond_to do |format|
                if not item_save_status
                  errors = item.errors
                else
                  errors = production_que.errors
                end
                flash[:errors] = errors
                format.html { redirect_to action: "select_product_item" }
                format.json { render json: errors, status: :created }
              end
              raise ActiveRecord::Rollback
              break
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




end
