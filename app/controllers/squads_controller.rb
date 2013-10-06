class SquadsController < ApplicationController
  # GET /squads
  # GET /squads.json
  def index
    @squad = Squad.new
    @squads = Squad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @squads }
    end
  end

  # GET /squads/1
  # GET /squads/1.json
  def show
    @squad = Squad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @squad }
    end
  end

  # GET /squads/new
  # GET /squads/new.json
  def new
    @squad = Squad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @squad }
    end
  end

  # GET /squads/1/edit
  def edit
    @squad = Squad.find(params[:id])
  end

  # POST /squads
  # POST /squads.json
  def create
    @squad = Squad.new(params[:squad])

    respond_to do |format|
      if @squad.save
        format.html { redirect_to @squad, notice: 'Squad was successfully created.' }
        format.json { render json: @squad, status: :created, location: @squad }
      else
        format.html { render action: "new" }
        format.json { render json: @squad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /squads/1
  # PUT /squads/1.json
  def update
    @squad = Squad.find(params[:id])

    respond_to do |format|
      if @squad.update_attributes(params[:squad])
        format.html { redirect_to @squad, notice: 'Squad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @squad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /squads/1
  # DELETE /squads/1.json
  def destroy
    @squad = Squad.find(params[:id])
    @squad.destroy

    respond_to do |format|
      format.html { redirect_to squads_url }
      format.json { head :no_content }
    end
  end
end
