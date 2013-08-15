class FortressCellsController < ApplicationController
  # GET /fortress_cells
  # GET /fortress_cells.json
  def index
    @fortress_cell = FortressCell.new
    @fortress_cells = FortressCell.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fortress_cells }
    end
  end

  # GET /fortress_cells/1
  # GET /fortress_cells/1.json
  def show
    @fortress_cell = FortressCell.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fortress_cell }
    end
  end

  # GET /fortress_cells/new
  # GET /fortress_cells/new.json
  def new
    @fortress_cell = FortressCell.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fortress_cell }
    end
  end

  # GET /fortress_cells/1/edit
  def edit
    @fortress_cell = FortressCell.find(params[:id])
  end

  # POST /fortress_cells
  # POST /fortress_cells.json
  def create
    @fortress_cell = FortressCell.new(params[:fortress_cell])

    respond_to do |format|
      if @fortress_cell.save
        format.html { redirect_to @fortress_cell, notice: 'Fortress cell was successfully created.' }
        format.json { render json: @fortress_cell, status: :created, location: @fortress_cell }
      else
        format.html { render action: "new" }
        format.json { render json: @fortress_cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fortress_cells/1
  # PUT /fortress_cells/1.json
  def update
    @fortress_cell = FortressCell.find(params[:id])

    respond_to do |format|
      if @fortress_cell.update_attributes(params[:fortress_cell])
        format.html { redirect_to @fortress_cell, notice: 'Fortress cell was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fortress_cell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fortress_cells/1
  # DELETE /fortress_cells/1.json
  def destroy
    @fortress_cell = FortressCell.find(params[:id])
    @fortress_cell.destroy

    respond_to do |format|
      format.html { redirect_to fortress_cells_url }
      format.json { head :no_content }
    end
  end
end
