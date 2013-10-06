class MiniMapCellsController < ApplicationController
  # GET /mini_map_cells
  # GET /mini_map_cells.json
  def index
    @mini_map_cell = MiniMapCell.new
    @mini_map_cells = MiniMapCell.find_all_by_mini_map_id(params[:map_id].to_i)
    @mini_map_id = params[:map_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mini_map_cells }
    end
  end

  # GET /mini_map_cells/1
  # GET /mini_map_cells/1.json
  def show
    @mini_map_cell = MiniMapCell.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mini_map_cell }
    end
  end

  # GET /mini_map_cells/new
  # GET /mini_map_cells/new.json
  def new
    @mini_map_cell = MiniMapCell.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mini_map_cell }
    end
  end

  # GET /mini_map_cells/1/edit
  def edit
    @mini_map_cell = MiniMapCell.find(params[:id])
  end

  # POST /mini_map_cells
  # POST /mini_map_cells.json
  def create
    @mini_map_cell = MiniMapCell.new(params[:mini_map_cell])

    respond_to do |format|
      if @mini_map_cell.save
        format.html { redirect_to @mini_map_cell, notice: 'Mini map cell was successfully created.' }
        format.json { render json: @mini_map_cell, status: :created, location: @mini_map_cell }
      else
        format.html { render action: "new" }
        format.json { render json: @mini_map_cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mini_map_cells/1
  # PUT /mini_map_cells/1.json
  def update
    @mini_map_cell = MiniMapCell.find(params[:id])

    respond_to do |format|
      if @mini_map_cell.update_attributes(params[:mini_map_cell])
        format.html { redirect_to @mini_map_cell, notice: 'Mini map cell was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mini_map_cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mini_map_cells/1
  # DELETE /mini_map_cells/1.json
  def destroy
    @mini_map_cell = MiniMapCell.find(params[:id])
    @mini_map_cell.destroy

    respond_to do |format|
      format.html { redirect_to mini_map_cells_url }
      format.json { head :no_content }
    end
  end
end
