class StatusModInvsController < ApplicationController
  # GET /status_mod_invs
  # GET /status_mod_invs.json
  def index
    @status_mod_inv = StatusModInv.new
    @status_mod_invs = StatusModInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @status_mod_invs }
    end
  end

  # GET /status_mod_invs/1
  # GET /status_mod_invs/1.json
  def show
    @status_mod_inv = StatusModInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status_mod_inv }
    end
  end

  # GET /status_mod_invs/new
  # GET /status_mod_invs/new.json
  def new
    @status_mod_inv = StatusModInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status_mod_inv }
    end
  end

  # GET /status_mod_invs/1/edit
  def edit
    @status_mod_inv = StatusModInv.find(params[:id])
  end

  # POST /status_mod_invs
  # POST /status_mod_invs.json
  def create
    @status_mod_inv = StatusModInv.new(params[:status_mod_inv])

    respond_to do |format|
      if @status_mod_inv.save
        format.html { redirect_to @status_mod_inv, notice: 'Status mod inv was successfully created.' }
        format.json { render json: @status_mod_inv, status: :created, location: @status_mod_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /status_mod_invs/1
  # PUT /status_mod_invs/1.json
  def update
    @status_mod_inv = StatusModInv.find(params[:id])

    respond_to do |format|
      if @status_mod_inv.update_attributes(params[:status_mod_inv])
        format.html { redirect_to @status_mod_inv, notice: 'Status mod inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_mod_invs/1
  # DELETE /status_mod_invs/1.json
  def destroy
    @status_mod_inv = StatusModInv.find(params[:id])
    @status_mod_inv.destroy

    respond_to do |format|
      format.html { redirect_to status_mod_invs_url }
      format.json { head :no_content }
    end
  end
end
