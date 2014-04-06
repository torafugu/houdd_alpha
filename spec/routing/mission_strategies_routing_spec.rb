require "spec_helper"

describe MissionStrategiesController do
  describe "routing" do

    it "routes to #index" do
      get("/mission_strategies").should route_to("mission_strategies#index")
    end

    it "routes to #new" do
      get("/mission_strategies/new").should route_to("mission_strategies#new")
    end

    it "routes to #show" do
      get("/mission_strategies/1").should route_to("mission_strategies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mission_strategies/1/edit").should route_to("mission_strategies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mission_strategies").should route_to("mission_strategies#create")
    end

    it "routes to #update" do
      put("/mission_strategies/1").should route_to("mission_strategies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mission_strategies/1").should route_to("mission_strategies#destroy", :id => "1")
    end

  end
end
