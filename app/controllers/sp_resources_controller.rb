class SpResourcesController < ApplicationController
  # GET /sp_resources
  # GET /sp_resources.json
  def index
    @sp_resource = SpResource.new
    @sp_resources = SpResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sp_resources }
    end
  end

  # GET /sp_resources/1
  # GET /sp_resources/1.json
  def show
    @sp_resource = SpResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sp_resource }
    end
  end

  # GET /sp_resources/new
  # GET /sp_resources/new.json
  def new
    @sp_resource = SpResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sp_resource }
    end
  end

  # GET /sp_resources/1/edit
  def edit
    @sp_resource = SpResource.find(params[:id])
  end

  # POST /sp_resources
  # POST /sp_resources.json
  def create
    @sp_resource = SpResource.new(params[:sp_resource])

    respond_to do |format|
      if @sp_resource.save
        format.html { redirect_to @sp_resource, notice: 'Sp resource was successfully created.' }
        format.json { render json: @sp_resource, status: :created, location: @sp_resource }
      else
        format.html { render action: "new" }
        format.json { render json: @sp_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sp_resources/1
  # PUT /sp_resources/1.json
  def update
    @sp_resource = SpResource.find(params[:id])

    respond_to do |format|
      if @sp_resource.update_attributes(params[:sp_resource])
        format.html { redirect_to @sp_resource, notice: 'Sp resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sp_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sp_resources/1
  # DELETE /sp_resources/1.json
  def destroy
    @sp_resource = SpResource.find(params[:id])
    @sp_resource.destroy

    respond_to do |format|
      format.html { redirect_to sp_resources_url }
      format.json { head :no_content }
    end
  end
end
