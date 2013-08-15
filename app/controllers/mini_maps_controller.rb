class MiniMapsController < ApplicationController
  # GET /mini_maps
  # GET /mini_maps.json
  def index
    @mini_map = MiniMap.new
    @mini_maps = MiniMap.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mini_maps }
    end
  end

  # GET /mini_maps/1
  # GET /mini_maps/1.json
  def show
    @mini_map = MiniMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mini_map }
    end
  end

  # GET /mini_maps/new
  # GET /mini_maps/new.json
  def new
    @mini_map = MiniMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mini_map }
    end
  end

  # GET /mini_maps/1/edit
  def edit
    @mini_map = MiniMap.find(params[:id])
  end

  # POST /mini_maps
  # POST /mini_maps.json
  def create
    @mini_map = MiniMap.new(params[:mini_map])

    respond_to do |format|
      if @mini_map.save
        format.html { redirect_to @mini_map, notice: 'Mini map was successfully created.' }
        format.json { render json: @mini_map, status: :created, location: @mini_map }
      else
        format.html { render action: "new" }
        format.json { render json: @mini_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mini_maps/1
  # PUT /mini_maps/1.json
  def update
    @mini_map = MiniMap.find(params[:id])

    respond_to do |format|
      if @mini_map.update_attributes(params[:mini_map])
        format.html { redirect_to @mini_map, notice: 'Mini map was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mini_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mini_maps/1
  # DELETE /mini_maps/1.json
  def destroy
    @mini_map = MiniMap.find(params[:id])
    @mini_map.destroy

    respond_to do |format|
      format.html { redirect_to mini_maps_url }
      format.json { head :no_content }
    end
  end
end
