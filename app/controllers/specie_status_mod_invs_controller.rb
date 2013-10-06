class SpecieStatusModInvsController < ApplicationController
  # GET /specie_status_mod_invs
  # GET /specie_status_mod_invs.json
  def index
    @specie_status_mod_inv = SpecieStatusModInv.new
    @specie_status_mod_invs = SpecieStatusModInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specie_status_mod_invs }
    end
  end

  # GET /specie_status_mod_invs/1
  # GET /specie_status_mod_invs/1.json
  def show
    @specie_status_mod_inv = SpecieStatusModInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @specie_status_mod_inv }
    end
  end

  # GET /specie_status_mod_invs/new
  # GET /specie_status_mod_invs/new.json
  def new
    @specie_status_mod_inv = SpecieStatusModInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specie_status_mod_inv }
    end
  end

  # GET /specie_status_mod_invs/1/edit
  def edit
    @specie_status_mod_inv = SpecieStatusModInv.find(params[:id])
  end

  # POST /specie_status_mod_invs
  # POST /specie_status_mod_invs.json
  def create
    @specie_status_mod_inv = SpecieStatusModInv.new(params[:specie_status_mod_inv])

    respond_to do |format|
      if @specie_status_mod_inv.save
        format.html { redirect_to @specie_status_mod_inv, notice: 'Status mod inv was successfully created.' }
        format.json { render json: @specie_status_mod_inv, status: :created, location: @specie_status_mod_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @specie_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specie_status_mod_invs/1
  # PUT /specie_status_mod_invs/1.json
  def update
    @specie_status_mod_inv = SpecieStatusModInv.find(params[:id])

    respond_to do |format|
      if @specie_status_mod_inv.update_attributes(params[:specie_status_mod_inv])
        format.html { redirect_to @specie_status_mod_inv, notice: 'Status mod inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @specie_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specie_status_mod_invs/1
  # DELETE /specie_status_mod_invs/1.json
  def destroy
    @specie_status_mod_inv = SpecieStatusModInv.find(params[:id])
    @specie_status_mod_inv.destroy

    respond_to do |format|
      format.html { redirect_to specie_status_mod_invs_url }
      format.json { head :no_content }
    end
  end
end
