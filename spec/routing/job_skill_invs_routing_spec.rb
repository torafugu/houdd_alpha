require "spec_helper"

describe JobSkillInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/job_skill_invs").should route_to("job_skill_invs#index")
    end

    it "routes to #new" do
      get("/job_skill_invs/new").should route_to("job_skill_invs#new")
    end

    it "routes to #show" do
      get("/job_skill_invs/1").should route_to("job_skill_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/job_skill_invs/1/edit").should route_to("job_skill_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/job_skill_invs").should route_to("job_skill_invs#create")
    end

    it "routes to #update" do
      put("/job_skill_invs/1").should route_to("job_skill_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/job_skill_invs/1").should route_to("job_skill_invs#destroy", :id => "1")
    end

  end
end
