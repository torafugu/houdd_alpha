class BodyPartsController < ApplicationController
  # GET /body_parts
  # GET /body_parts.json
  def index
    @body_part = BodyPart.new
    @body_parts = BodyPart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_parts }
    end
  end

  # GET /body_parts/1
  # GET /body_parts/1.json
  def show
    @body_part = BodyPart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_part }
    end
  end

  # GET /body_parts/new
  # GET /body_parts/new.json
  def new
    @body_part = BodyPart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_part }
    end
  end

  # GET /body_parts/1/edit
  def edit
    @body_part = BodyPart.find(params[:id])
  end

  # POST /body_parts
  # POST /body_parts.json
  def create
    @body_part = BodyPart.new(params[:body_part])

    respond_to do |format|
      if @body_part.save
        format.html { redirect_to @body_part, notice: 'Body part was successfully created.' }
        format.json { render json: @body_part, status: :created, location: @body_part }
      else
        format.html { render action: "new" }
        format.json { render json: @body_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_parts/1
  # PUT /body_parts/1.json
  def update
    @body_part = BodyPart.find(params[:id])

    respond_to do |format|
      if @body_part.update_attributes(params[:body_part])
        format.html { redirect_to @body_part, notice: 'Body part was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_parts/1
  # DELETE /body_parts/1.json
  def destroy
    @body_part = BodyPart.find(params[:id])
    @body_part.destroy

    respond_to do |format|
      format.html { redirect_to body_parts_url }
      format.json { head :no_content }
    end
  end
end
