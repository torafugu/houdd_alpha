class MissionStrategiesController < ApplicationController
  # GET /mission_strategies
  # GET /mission_strategies.json
  def index
    @mission_strategy = MissionStrategy.new
    @mission_strategies = MissionStrategy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mission_strategies }
    end
  end

  # GET /mission_strategies/1
  # GET /mission_strategies/1.json
  def show
    @mission_strategy = MissionStrategy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission_strategy }
    end
  end

  # GET /mission_strategies/new
  # GET /mission_strategies/new.json
  def new
    @mission_strategy = MissionStrategy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission_strategy }
    end
  end

  # GET /mission_strategies/1/edit
  def edit
    @mission_strategy = MissionStrategy.find(params[:id])
  end

  # POST /mission_strategies
  # POST /mission_strategies.json
  def create
    @mission_strategy = MissionStrategy.new(params[:mission_strategy])

    respond_to do |format|
      if @mission_strategy.save
        format.html { redirect_to @mission_strategy, notice: 'Mission strategy was successfully created.' }
        format.json { render json: @mission_strategy, status: :created, location: @mission_strategy }
      else
        format.html { render action: "new" }
        format.json { render json: @mission_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mission_strategies/1
  # PUT /mission_strategies/1.json
  def update
    @mission_strategy = MissionStrategy.find(params[:id])

    respond_to do |format|
      if @mission_strategy.update_attributes(params[:mission_strategy])
        format.html { redirect_to @mission_strategy, notice: 'Mission strategy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_strategies/1
  # DELETE /mission_strategies/1.json
  def destroy
    @mission_strategy = MissionStrategy.find(params[:id])
    @mission_strategy.destroy

    respond_to do |format|
      format.html { redirect_to mission_strategies_url }
      format.json { head :no_content }
    end
  end
end
