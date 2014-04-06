class MobsController < ApplicationController
  # GET /mobs
  # GET /mobs.json
  # GET /mobs/:user_id/:specie_id/index
  # GET /mobs/:user_id/:specie_id/index.json
  def index
    @mob = Mob.new
    @mobs = Array.new

    user_id = params[:user_id]
    user_id = nil if user_id == '0'
    @houdd_user_id = user_id

    specie_id = params[:specie_id]
    specie_id = nil if specie_id == '0'
    @mob_specie_id = specie_id

    if not user_id.blank? and not specie_id.blank?
      @mobs = Mob.find_all_by_houdd_user_id_and_specie_id(user_id, specie_id)
    elsif not user_id.blank?
      @mobs = Mob.find_all_by_houdd_user_id(user_id)
    elsif not specie_id.blank?
      @mobs = Mob.find_all_by_specie_id(specie_id)
    end

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

  # GET /mobs/1/select_specie
  def select_specie
    @species = HouddUser.find(params[:user_id]).species.collect{|m| [m.name, m.id]}.insert(0, "")

    respond_to do |format|
      format.js # select_specie.js.coffee
    end
  end
end
