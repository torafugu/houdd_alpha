class MapItemInvsController < ApplicationController
  # GET /map_item_invs
  # GET /map_item_invs.json
  def index
    @map_item_inv = MapItemInv.new
    @map_item_invs = MapItemInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @map_item_invs }
    end
  end

  # GET /map_item_invs/1
  # GET /map_item_invs/1.json
  def show
    @map_item_inv = MapItemInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @map_item_inv }
    end
  end

  # GET /map_item_invs/new
  # GET /map_item_invs/new.json
  def new
    @map_item_inv = MapItemInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @map_item_inv }
    end
  end

  # GET /map_item_invs/1/edit
  def edit
    @map_item_inv = MapItemInv.find(params[:id])
  end

  # POST /map_item_invs
  # POST /map_item_invs.json
  def create
    @map_item_inv = MapItemInv.new(params[:map_item_inv])

    respond_to do |format|
      if @map_item_inv.save
        format.html { redirect_to @map_item_inv, notice: 'Map item inv was successfully created.' }
        format.json { render json: @map_item_inv, status: :created, location: @map_item_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @map_item_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /map_item_invs/1
  # PUT /map_item_invs/1.json
  def update
    @map_item_inv = MapItemInv.find(params[:id])

    respond_to do |format|
      if @map_item_inv.update_attributes(params[:map_item_inv])
        format.html { redirect_to @map_item_inv, notice: 'Map item inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @map_item_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /map_item_invs/1
  # DELETE /map_item_invs/1.json
  def destroy
    @map_item_inv = MapItemInv.find(params[:id])
    @map_item_inv.destroy

    respond_to do |format|
      format.html { redirect_to map_item_invs_url }
      format.json { head :no_content }
    end
  end
end
