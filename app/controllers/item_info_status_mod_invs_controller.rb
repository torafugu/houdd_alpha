class ItemInfoStatusModInvsController < ApplicationController
  # GET /item_info_status_mod_invs
  # GET /item_info_status_mod_invs.json
  def index
    @item_info_status_mod_inv = ItemInfoStatusModInv.new
    @item_info_status_mod_invs = ItemInfoStatusModInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_info_status_mod_invs }
    end
  end

  # GET /item_info_status_mod_invs/1
  # GET /item_info_status_mod_invs/1.json
  def show
    @item_info_status_mod_inv = ItemInfoStatusModInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_info_status_mod_inv }
    end
  end

  # GET /item_info_status_mod_invs/new
  # GET /item_info_status_mod_invs/new.json
  def new
    @item_info_status_mod_inv = ItemInfoStatusModInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_info_status_mod_inv }
    end
  end

  # GET /item_info_status_mod_invs/1/edit
  def edit
    @item_info_status_mod_inv = ItemInfoStatusModInv.find(params[:id])
  end

  # POST /item_info_status_mod_invs
  # POST /item_info_status_mod_invs.json
  def create
    @item_info_status_mod_inv = ItemInfoStatusModInv.new(params[:item_info_status_mod_inv])

    respond_to do |format|
      if @item_info_status_mod_inv.save
        format.html { redirect_to @item_info_status_mod_inv, notice: 'Status mod inv was successfully created.' }
        format.json { render json: @item_info_status_mod_inv, status: :created, location: @item_info_status_mod_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @item_info_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_info_status_mod_invs/1
  # PUT /item_info_status_mod_invs/1.json
  def update
    @item_info_status_mod_inv = ItemInfoStatusModInv.find(params[:id])

    respond_to do |format|
      if @item_info_status_mod_inv.update_attributes(params[:item_info_status_mod_inv])
        format.html { redirect_to @item_info_status_mod_inv, notice: 'Status mod inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_info_status_mod_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_info_status_mod_invs/1
  # DELETE /item_info_status_mod_invs/1.json
  def destroy
    @item_info_status_mod_inv = ItemInfoStatusModInv.find(params[:id])
    @item_info_status_mod_inv.destroy

    respond_to do |format|
      format.html { redirect_to item_info_status_mod_invs_url }
      format.json { head :no_content }
    end
  end
end
