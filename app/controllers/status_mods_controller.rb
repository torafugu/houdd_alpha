class StatusModsController < ApplicationController
  # GET /status_mods
  # GET /status_mods.json
  def index
    @status_mod = StatusMod.new
    @status_mods = StatusMod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @status_mods }
    end
  end

  # GET /status_mods/1
  # GET /status_mods/1.json
  def show
    @status_mod = StatusMod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status_mod }
    end
  end

  # GET /status_mods/new
  # GET /status_mods/new.json
  def new
    @status_mod = StatusMod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status_mod }
    end
  end

  # GET /status_mods/1/edit
  def edit
    @status_mod = StatusMod.find(params[:id])
  end

  # POST /status_mods
  # POST /status_mods.json
  def create
    @status_mod = StatusMod.new(params[:status_mod])

    respond_to do |format|
      if @status_mod.save
        format.html { redirect_to @status_mod, notice: 'Status mod was successfully created.' }
        format.json { render json: @status_mod, status: :created, location: @status_mod }
      else
        format.html { render action: "new" }
        format.json { render json: @status_mod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status_mods/1
  # PUT /status_mods/1.json
  def update
    @status_mod = StatusMod.find(params[:id])

    respond_to do |format|
      if @status_mod.update_attributes(params[:status_mod])
        format.html { redirect_to @status_mod, notice: 'Status mod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status_mod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_mods/1
  # DELETE /status_mods/1.json
  def destroy
    @status_mod = StatusMod.find(params[:id])
    @status_mod.destroy

    respond_to do |format|
      format.html { redirect_to status_mods_url }
      format.json { head :no_content }
    end
  end
end
