require "spec_helper"

describe SkillInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/skill_invs").should route_to("skill_invs#index")
    end

    it "routes to #new" do
      get("/skill_invs/new").should route_to("skill_invs#new")
    end

    it "routes to #show" do
      get("/skill_invs/1").should route_to("skill_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/skill_invs/1/edit").should route_to("skill_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/skill_invs").should route_to("skill_invs#create")
    end

    it "routes to #update" do
      put("/skill_invs/1").should route_to("skill_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/skill_invs/1").should route_to("skill_invs#destroy", :id => "1")
    end

  end
end
