class DnasController < ApplicationController
  # GET /dnas
  # GET /dnas.json
  def index
    @dna = Dna.new
    @dnas = Dna.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dnas }
    end
  end

  # GET /dnas/1
  # GET /dnas/1.json
  def show
    @dna = Dna.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dna }
    end
  end

  # GET /dnas/new
  # GET /dnas/new.json
  def new
    @dna = Dna.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dna }
    end
  end

  # GET /dnas/1/edit
  def edit
    @dna = Dna.find(params[:id])
  end

  # POST /dnas
  # POST /dnas.json
  def create
    @dna = Dna.new(params[:dna])

    respond_to do |format|
      if @dna.save
        format.html { redirect_to @dna, notice: 'Dna was successfully created.' }
        format.json { render json: @dna, status: :created, location: @dna }
      else
        format.html { render action: "new" }
        format.json { render json: @dna.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dnas/1
  # PUT /dnas/1.json
  def update
    @dna = Dna.find(params[:id])

    respond_to do |format|
      if @dna.update_attributes(params[:dna])
        format.html { redirect_to @dna, notice: 'Dna was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dna.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dnas/1
  # DELETE /dnas/1.json
  def destroy
    @dna = Dna.find(params[:id])
    @dna.destroy

    respond_to do |format|
      format.html { redirect_to dnas_url }
      format.json { head :no_content }
    end
  end
end
