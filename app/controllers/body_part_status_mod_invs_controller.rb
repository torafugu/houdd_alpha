class BodyPartStatusModInvsController < ApplicationController
  # GET /body_part_status_mod_invs
  # GET /body_part_status_mod_invs.json
  def index
    @body_part_status_mod_inv = BodyPartStatusModInv.new
    @body_part_status_mod_invs = BodyPartStatusModInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_part_status_mod_invs }
    end
  end

  # GET /body_part_status_mod_invs/1
  # GET /body_part_status_mod_invs/1.json
  def show
    @body_part_status_mod_inv = BodyPartStatusModInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_part_status_mod_inv }
    end
  end

  # GET /body_part_status_mod_invs/new
  # GET /body_part_status_mod_invs/new.json
  def new
    @body_part_status_mod_inv = BodyPartStatusModInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_part_status_mod_inv }
    end
  end

  # GET /body_part_status_mod_invs/1/edit
  def edit
    @body_part_status_mod_inv = BodyPartStatusModInv.find(params[:id])
  end

  # POST /body_part_status_mod_invs
  # POST /body_part_status_mod_invs.json
  def create
    @body_part_status_mod_inv = BodyPartStatusModInv.new(params[:body_part_status_mod_inv])

    respond_to do |format|
      if @body_part_status_mod_inv.save
        format.html { redirect_to @body_part_status_mod_inv, notice: 'Status mod inv was successfully created.' }
        format.json { render json: @body_part_status_mod_inv, status: :created, location: @body_part_status_mod_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @body_part_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_part_status_mod_invs/1
  # PUT /body_part_status_mod_invs/1.json
  def update
    @body_part_status_mod_inv = BodyPartStatusModInv.find(params[:id])

    respond_to do |format|
      if @body_part_status_mod_inv.update_attributes(params[:body_part_status_mod_inv])
        format.html { redirect_to @body_part_status_mod_inv, notice: 'Status mod inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_part_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_part_status_mod_invs/1
  # DELETE /body_part_status_mod_invs/1.json
  def destroy
    @body_part_status_mod_inv = BodyPartStatusModInv.find(params[:id])
    @body_part_status_mod_inv.destroy

    respond_to do |format|
      format.html { redirect_to body_part_status_mod_invs_url }
      format.json { head :no_content }
    end
  end
end
