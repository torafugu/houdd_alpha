require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe JobSkillInvsController do

  # This should return the minimal set of attributes required to create a valid
  # JobSkillInv. As you add validations to JobSkillInv, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "skill" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobSkillInvsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all job_skill_invs as @job_skill_invs" do
      job_skill_inv = JobSkillInv.create! valid_attributes
      get :index, {}, valid_session
      assigns(:job_skill_invs).should eq([job_skill_inv])
    end
  end

  describe "GET show" do
    it "assigns the requested job_skill_inv as @job_skill_inv" do
      job_skill_inv = JobSkillInv.create! valid_attributes
      get :show, {:id => job_skill_inv.to_param}, valid_session
      assigns(:job_skill_inv).should eq(job_skill_inv)
    end
  end

  describe "GET new" do
    it "assigns a new job_skill_inv as @job_skill_inv" do
      get :new, {}, valid_session
      assigns(:job_skill_inv).should be_a_new(JobSkillInv)
    end
  end

  describe "GET edit" do
    it "assigns the requested job_skill_inv as @job_skill_inv" do
      job_skill_inv = JobSkillInv.create! valid_attributes
      get :edit, {:id => job_skill_inv.to_param}, valid_session
      assigns(:job_skill_inv).should eq(job_skill_inv)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new JobSkillInv" do
        expect {
          post :create, {:job_skill_inv => valid_attributes}, valid_session
        }.to change(JobSkillInv, :count).by(1)
      end

      it "assigns a newly created job_skill_inv as @job_skill_inv" do
        post :create, {:job_skill_inv => valid_attributes}, valid_session
        assigns(:job_skill_inv).should be_a(JobSkillInv)
        assigns(:job_skill_inv).should be_persisted
      end

      it "redirects to the created job_skill_inv" do
        post :create, {:job_skill_inv => valid_attributes}, valid_session
        response.should redirect_to(JobSkillInv.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved job_skill_inv as @job_skill_inv" do
        # Trigger the behavior that occurs when invalid params are submitted
        JobSkillInv.any_instance.stub(:save).and_return(false)
        post :create, {:job_skill_inv => { "skill" => "invalid value" }}, valid_session
        assigns(:job_skill_inv).should be_a_new(JobSkillInv)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        JobSkillInv.any_instance.stub(:save).and_return(false)
        post :create, {:job_skill_inv => { "skill" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested job_skill_inv" do
        job_skill_inv = JobSkillInv.create! valid_attributes
        # Assuming there are no other job_skill_invs in the database, this
        # specifies that the JobSkillInv created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        JobSkillInv.any_instance.should_receive(:update_attributes).with({ "skill" => "" })
        put :update, {:id => job_skill_inv.to_param, :job_skill_inv => { "skill" => "" }}, valid_session
      end

      it "assigns the requested job_skill_inv as @job_skill_inv" do
        job_skill_inv = JobSkillInv.create! valid_attributes
        put :update, {:id => job_skill_inv.to_param, :job_skill_inv => valid_attributes}, valid_session
        assigns(:job_skill_inv).should eq(job_skill_inv)
      end

      it "redirects to the job_skill_inv" do
        job_skill_inv = JobSkillInv.create! valid_attributes
        put :update, {:id => job_skill_inv.to_param, :job_skill_inv => valid_attributes}, valid_session
        response.should redirect_to(job_skill_inv)
      end
    end

    describe "with invalid params" do
      it "assigns the job_skill_inv as @job_skill_inv" do
        job_skill_inv = JobSkillInv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JobSkillInv.any_instance.stub(:save).and_return(false)
        put :update, {:id => job_skill_inv.to_param, :job_skill_inv => { "skill" => "invalid value" }}, valid_session
        assigns(:job_skill_inv).should eq(job_skill_inv)
      end

      it "re-renders the 'edit' template" do
        job_skill_inv = JobSkillInv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JobSkillInv.any_instance.stub(:save).and_return(false)
        put :update, {:id => job_skill_inv.to_param, :job_skill_inv => { "skill" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested job_skill_inv" do
      job_skill_inv = JobSkillInv.create! valid_attributes
      expect {
        delete :destroy, {:id => job_skill_inv.to_param}, valid_session
      }.to change(JobSkillInv, :count).by(-1)
    end

    it "redirects to the job_skill_invs list" do
      job_skill_inv = JobSkillInv.create! valid_attributes
      delete :destroy, {:id => job_skill_inv.to_param}, valid_session
      response.should redirect_to(job_skill_invs_url)
    end
  end

end
