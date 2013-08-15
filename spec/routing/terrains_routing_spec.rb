require "spec_helper"

describe TerrainsController do
  describe "routing" do

    it "routes to #index" do
      get("/terrains").should route_to("terrains#index")
    end

    it "routes to #new" do
      get("/terrains/new").should route_to("terrains#new")
    end

    it "routes to #show" do
      get("/terrains/1").should route_to("terrains#show", :id => "1")
    end

    it "routes to #edit" do
      get("/terrains/1/edit").should route_to("terrains#edit", :id => "1")
    end

    it "routes to #create" do
      post("/terrains").should route_to("terrains#create")
    end

    it "routes to #update" do
      put("/terrains/1").should route_to("terrains#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/terrains/1").should route_to("terrains#destroy", :id => "1")
    end

  end
end
