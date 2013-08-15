class TerrainsController < ApplicationController
  # GET /terrains
  # GET /terrains.json
  def index
    @terrain = Terrain.new
    @terrains = Terrain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terrains }
    end
  end

  # GET /terrains/1
  # GET /terrains/1.json
  def show
    @terrain = Terrain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @terrain }
    end
  end

  # GET /terrains/new
  # GET /terrains/new.json
  def new
    @terrain = Terrain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @terrain }
    end
  end

  # GET /terrains/1/edit
  def edit
    @terrain = Terrain.find(params[:id])
  end

  # POST /terrains
  # POST /terrains.json
  def create
    @terrain = Terrain.new(params[:terrain])

    respond_to do |format|
      if @terrain.save
        format.html { redirect_to @terrain, notice: 'Terrain was successfully created.' }
        format.json { render json: @terrain, status: :created, location: @terrain }
      else
        format.html { render action: "new" }
        format.json { render json: @terrain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /terrains/1
  # PUT /terrains/1.json
  def update
    @terrain = Terrain.find(params[:id])

    respond_to do |format|
      if @terrain.update_attributes(params[:terrain])
        format.html { redirect_to @terrain, notice: 'Terrain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @terrain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terrains/1
  # DELETE /terrains/1.json
  def destroy
    @terrain = Terrain.find(params[:id])
    @terrain.destroy

    respond_to do |format|
      format.html { redirect_to terrains_url }
      format.json { head :no_content }
    end
  end
end
