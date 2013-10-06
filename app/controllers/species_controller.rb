class SpeciesController < ApplicationController
  # GET /species
  # GET /species.json
  def index
    @specie = Specie.new
    @species = Specie.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @species }
    end
  end

  # GET /species/1
  # GET /species/1.json
  def show
    @specie = Specie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @specie }
    end
  end

  # GET /species/new
  # GET /species/new.json
  def new
    @specie = Specie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specie }
    end
  end

  # GET /species/1/edit
  def edit
    @specie = Specie.find(params[:id])
  end

  # POST /species
  # POST /species.json
  def create
    @specie = Specie.new(params[:specie])

    respond_to do |format|
      if @specie.save
        format.html { redirect_to @specie, notice: 'Specie was successfully created.' }
        format.json { render json: @specie, status: :created, location: @specie }
      else
        format.html { render action: "new" }
        format.json { render json: @specie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /species/1
  # PUT /species/1.json
  def update
    @specie = Specie.find(params[:id])

    respond_to do |format|
      if @specie.update_attributes(params[:specie])
        format.html { redirect_to @specie, notice: 'Specie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @specie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /species/1
  # DELETE /species/1.json
  def destroy
    @specie = Specie.find(params[:id])
    @specie.destroy

    respond_to do |format|
      format.html { redirect_to species_url }
      format.json { head :no_content }
    end
  end
end
