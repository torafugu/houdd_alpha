class SpecieJobInvsController < ApplicationController
  # GET /specie_job_invs
  # GET /specie_job_invs.json
  def index
    @specie_job_inv = SpecieJobInv.new
    @specie_job_invs = SpecieJobInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specie_job_invs }
    end
  end

  # GET /specie_job_invs/1
  # GET /specie_job_invs/1.json
  def show
    @specie_job_inv = SpecieJobInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @specie_job_inv }
    end
  end

  # GET /specie_job_invs/new
  # GET /specie_job_invs/new.json
  def new
    @specie_job_inv = SpecieJobInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @specie_job_inv }
    end
  end

  # GET /specie_job_invs/1/edit
  def edit
    @specie_job_inv = SpecieJobInv.find(params[:id])
  end

  # POST /specie_job_invs
  # POST /specie_job_invs.json
  def create
    @specie_job_inv = SpecieJobInv.new(params[:specie_job_inv])

    respond_to do |format|
      if @specie_job_inv.save
        format.html { redirect_to @specie_job_inv, notice: 'Specie job inv was successfully created.' }
        format.json { render json: @specie_job_inv, status: :created, location: @specie_job_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @specie_job_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specie_job_invs/1
  # PUT /specie_job_invs/1.json
  def update
    @specie_job_inv = SpecieJobInv.find(params[:id])

    respond_to do |format|
      if @specie_job_inv.update_attributes(params[:specie_job_inv])
        format.html { redirect_to @specie_job_inv, notice: 'Specie job inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @specie_job_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specie_job_invs/1
  # DELETE /specie_job_invs/1.json
  def destroy
    @specie_job_inv = SpecieJobInv.find(params[:id])
    @specie_job_inv.destroy

    respond_to do |format|
      format.html { redirect_to specie_job_invs_url }
      format.json { head :no_content }
    end
  end
end
