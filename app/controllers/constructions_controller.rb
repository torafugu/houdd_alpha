class ConstructionsController < ApplicationController
  # GET /constructions
  # GET /constructions.json
  def index
    @construction = Construction.new
    @constructions = Construction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @constructions }
    end
  end

  # GET /constructions/1
  # GET /constructions/1.json
  def show
    @construction = Construction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction }
    end
  end

  # GET /constructions/new
  # GET /constructions/new.json
  def new
    @construction = Construction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction }
    end
  end

  # GET /constructions/1/edit
  def edit
    @construction = Construction.find(params[:id])
  end

  # POST /constructions
  # POST /constructions.json
  def create
    @construction = Construction.new(params[:construction])

    respond_to do |format|
      if @construction.save
        format.html { redirect_to @construction, notice: 'Construction was successfully created.' }
        format.json { render json: @construction, status: :created, location: @construction }
      else
        format.html { render action: "new" }
        format.json { render json: @construction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /constructions/1
  # PUT /constructions/1.json
  def update
    @construction = Construction.find(params[:id])

    respond_to do |format|
      if @construction.update_attributes(params[:construction])
        format.html { redirect_to @construction, notice: 'Construction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /constructions/1
  # DELETE /constructions/1.json
  def destroy
    @construction = Construction.find(params[:id])
    @construction.destroy

    respond_to do |format|
      format.html { redirect_to constructions_url }
      format.json { head :no_content }
    end
  end
end
