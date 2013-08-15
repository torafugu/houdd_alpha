class HouddUsersController < ApplicationController
  # GET /houdd_users
  # GET /houdd_users.json
  def index
    @houdd_user = HouddUser.new
    @houdd_users = HouddUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @houdd_users }
    end
  end

  # GET /houdd_users/1
  # GET /houdd_users/1.json
  def show
    @houdd_user = HouddUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @houdd_user }
    end
  end

  # GET /houdd_users/new
  # GET /houdd_users/new.json
  def new
    @houdd_user = HouddUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @houdd_user }
    end
  end

  # GET /houdd_users/1/edit
  def edit
    @houdd_user = HouddUser.find(params[:id])
  end

  # POST /houdd_users
  # POST /houdd_users.json
  def create
    @houdd_user = HouddUser.new(params[:houdd_user])

    respond_to do |format|
      if @houdd_user.save
        format.html { redirect_to @houdd_user, notice: 'Houdd user was successfully created.' }
        format.json { render json: @houdd_user, status: :created, location: @houdd_user }
      else
        format.html { render action: "new" }
        format.json { render json: @houdd_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /houdd_users/1
  # PUT /houdd_users/1.json
  def update
    @houdd_user = HouddUser.find(params[:id])

    respond_to do |format|
      if @houdd_user.update_attributes(params[:houdd_user])
        format.html { redirect_to @houdd_user, notice: 'Houdd user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @houdd_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houdd_users/1
  # DELETE /houdd_users/1.json
  def destroy
    @houdd_user = HouddUser.find(params[:id])
    @houdd_user.destroy

    respond_to do |format|
      format.html { redirect_to houdd_users_url }
      format.json { head :no_content }
    end
  end
end
