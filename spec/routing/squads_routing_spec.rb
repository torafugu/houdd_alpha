require "spec_helper"

describe SquadsController do
  describe "routing" do

    it "routes to #index" do
      get("/squads").should route_to("squads#index")
    end

    it "routes to #new" do
      get("/squads/new").should route_to("squads#new")
    end

    it "routes to #show" do
      get("/squads/1").should route_to("squads#show", :id => "1")
    end

    it "routes to #edit" do
      get("/squads/1/edit").should route_to("squads#edit", :id => "1")
    end

    it "routes to #create" do
      post("/squads").should route_to("squads#create")
    end

    it "routes to #update" do
      put("/squads/1").should route_to("squads#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/squads/1").should route_to("squads#destroy", :id => "1")
    end

  end
end
