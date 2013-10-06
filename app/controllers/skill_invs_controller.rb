class SkillInvsController < ApplicationController
  # GET /skill_invs
  # GET /skill_invs.json
  def index
    @skill_inv = SkillInv.new
    @skill_invs = SkillInv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skill_invs }
    end
  end

  # GET /skill_invs/1
  # GET /skill_invs/1.json
  def show
    @skill_inv = SkillInv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill_inv }
    end
  end

  # GET /skill_invs/new
  # GET /skill_invs/new.json
  def new
    @skill_inv = SkillInv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill_inv }
    end
  end

  # GET /skill_invs/1/edit
  def edit
    @skill_inv = SkillInv.find(params[:id])
  end

  # POST /skill_invs
  # POST /skill_invs.json
  def create
    @skill_inv = SkillInv.new(params[:skill_inv])

    respond_to do |format|
      if @skill_inv.save
        format.html { redirect_to @skill_inv, notice: 'Skill inv was successfully created.' }
        format.json { render json: @skill_inv, status: :created, location: @skill_inv }
      else
        format.html { render action: "new" }
        format.json { render json: @skill_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skill_invs/1
  # PUT /skill_invs/1.json
  def update
    @skill_inv = SkillInv.find(params[:id])

    respond_to do |format|
      if @skill_inv.update_attributes(params[:skill_inv])
        format.html { redirect_to @skill_inv, notice: 'Skill inv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill_inv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skill_invs/1
  # DELETE /skill_invs/1.json
  def destroy
    @skill_inv = SkillInv.find(params[:id])
    @skill_inv.destroy

    respond_to do |format|
      format.html { redirect_to skill_invs_url }
      format.json { head :no_content }
    end
  end
end
