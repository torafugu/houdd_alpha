class JobSkillInvsController < ApplicationController
  # GET /job_skill_invs
  # GET /job_skill_invs.json
  def index
    @job_skill_inv = JobSkillInv.new
    @job_skill_invs = JobSkillInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_skill_invs }
    end
  end

  # GET /job_skill_invs/1
  # GET /job_skill_invs/1.json
  def show
    @job_skill_inv = JobSkillInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_skill_inv }
    end
  end

  # GET /job_skill_invs/new
  # GET /job_skill_invs/new.json
  def new
    @job_skill_inv = JobSkillInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_skill_inv }
    end
  end

  # GET /job_skill_invs/1/edit
  def edit
    @job_skill_inv = JobSkillInv.find(params[:id])
  end

  # POST /job_skill_invs
  # POST /job_skill_invs.json
  def create
    @job_skill_inv = JobSkillInv.new(params[:job_skill_inv])

    respond_to do |format|
      if @job_skill_inv.save
        format.html { redirect_to @job_skill_inv, notice: 'Job skill inv was successfully created.' }
        format.json { render json: @job_skill_inv, status: :created, location: @job_skill_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @job_skill_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_skill_invs/1
  # PUT /job_skill_invs/1.json
  def update
    @job_skill_inv = JobSkillInv.find(params[:id])

    respond_to do |format|
      if @job_skill_inv.update_attributes(params[:job_skill_inv])
        format.html { redirect_to @job_skill_inv, notice: 'Job skill inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_skill_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_skill_invs/1
  # DELETE /job_skill_invs/1.json
  def destroy
    @job_skill_inv = JobSkillInv.find(params[:id])
    @job_skill_inv.destroy

    respond_to do |format|
      format.html { redirect_to job_skill_invs_url }
      format.json { head :no_content }
    end
  end
end
