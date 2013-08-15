class MiniMapRoadsController < ApplicationController
  # GET /mini_map_roads
  # GET /mini_map_roads.json
  def index
    @mini_map_road = MiniMapRoad.new
    @mini_map_roads = MiniMapRoad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mini_map_roads }
    end
  end

  # GET /mini_map_roads/1
  # GET /mini_map_roads/1.json
  def show
    @mini_map_road = MiniMapRoad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mini_map_road }
    end
  end

  # GET /mini_map_roads/new
  # GET /mini_map_roads/new.json
  def new
    @mini_map_road = MiniMapRoad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mini_map_road }
    end
  end

  # GET /mini_map_roads/1/edit
  def edit
    @mini_map_road = MiniMapRoad.find(params[:id])
  end

  # POST /mini_map_roads
  # POST /mini_map_roads.json
  def create
    @mini_map_road = MiniMapRoad.new(params[:mini_map_road])

    respond_to do |format|
      if @mini_map_road.save
        format.html { redirect_to @mini_map_road, notice: 'Mini map road was successfully created.' }
        format.json { render json: @mini_map_road, status: :created, location: @mini_map_road }
      else
        format.html { render action: "new" }
        format.json { render json: @mini_map_road.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mini_map_roads/1
  # PUT /mini_map_roads/1.json
  def update
    @mini_map_road = MiniMapRoad.find(params[:id])

    respond_to do |format|
      if @mini_map_road.update_attributes(params[:mini_map_road])
        format.html { redirect_to @mini_map_road, notice: 'Mini map road was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mini_map_road.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mini_map_roads/1
  # DELETE /mini_map_roads/1.json
  def destroy
    @mini_map_road = MiniMapRoad.find(params[:id])
    @mini_map_road.destroy

    respond_to do |format|
      format.html { redirect_to mini_map_roads_url }
      format.json { head :no_content }
    end
  end
end
