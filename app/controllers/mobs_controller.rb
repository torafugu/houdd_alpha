class MobsController < ApplicationController
  # GET /mobs
  # GET /mobs.json
  def index
    @mob = Mob.new
    @mobs = Mob.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mobs }
    end
  end

  # GET /mobs/1
  # GET /mobs/1.json
  def show
    @mob = Mob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mob }
    end
  end

  # GET /mobs/new
  # GET /mobs/new.json
  def new
    @mob = Mob.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mob }
    end
  end

  # GET /mobs/1/edit
  def edit
    @mob = Mob.find(params[:id])
  end

  # POST /mobs
  # POST /mobs.json
  def create
    @mob = Mob.new(params[:mob])

    respond_to do |format|
      if @mob.save
        format.html { redirect_to @mob, notice: 'Mob was successfully created.' }
        format.json { render json: @mob, status: :created, location: @mob }
      else
        format.html { render action: "new" }
        format.json { render json: @mob.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mobs/1
  # PUT /mobs/1.json
  def update
    @mob = Mob.find(params[:id])

    respond_to do |format|
      if @mob.update_attributes(params[:mob])
        format.html { redirect_to @mob, notice: 'Mob was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mob.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobs/1
  # DELETE /mobs/1.json
  def destroy
    @mob = Mob.find(params[:id])
    @mob.destroy

    respond_to do |format|
      format.html { redirect_to mobs_url }
      format.json { head :no_content }
    end
  end
end
