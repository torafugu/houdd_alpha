class ItemSpResourceInvsController < ApplicationController
  # GET /item_sp_resource_invs
  # GET /item_sp_resource_invs.json
  def index
    @item_sp_resource_inv = ItemSpResourceInv.new
    @item_sp_resource_invs = ItemSpResourceInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_sp_resource_invs }
    end
  end

  # GET /item_sp_resource_invs/1
  # GET /item_sp_resource_invs/1.json
  def show
    @item_sp_resource_inv = ItemSpResourceInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_sp_resource_inv }
    end
  end

  # GET /item_sp_resource_invs/new
  # GET /item_sp_resource_invs/new.json
  def new
    @item_sp_resource_inv = ItemSpResourceInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_sp_resource_inv }
    end
  end

  # GET /item_sp_resource_invs/1/edit
  def edit
    @item_sp_resource_inv = ItemSpResourceInv.find(params[:id])
  end

  # POST /item_sp_resource_invs
  # POST /item_sp_resource_invs.json
  def create
    @item_sp_resource_inv = ItemSpResourceInv.new(params[:item_sp_resource_inv])

    respond_to do |format|
      if @item_sp_resource_inv.save
        format.html { redirect_to @item_sp_resource_inv, notice: 'Item sp resource inv was successfully created.' }
        format.json { render json: @item_sp_resource_inv, status: :created, location: @item_sp_resource_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @item_sp_resource_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_sp_resource_invs/1
  # PUT /item_sp_resource_invs/1.json
  def update
    @item_sp_resource_inv = ItemSpResourceInv.find(params[:id])

    respond_to do |format|
      if @item_sp_resource_inv.update_attributes(params[:item_sp_resource_inv])
        format.html { redirect_to @item_sp_resource_inv, notice: 'Item sp resource inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_sp_resource_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_sp_resource_invs/1
  # DELETE /item_sp_resource_invs/1.json
  def destroy
    @item_sp_resource_inv = ItemSpResourceInv.find(params[:id])
    @item_sp_resource_inv.destroy

    respond_to do |format|
      format.html { redirect_to item_sp_resource_invs_url }
      format.json { head :no_content }
    end
  end
end
