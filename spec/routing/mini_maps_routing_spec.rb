require "spec_helper"

describe MiniMapsController do
  describe "routing" do

    it "routes to #index" do
      get("/mini_maps").should route_to("mini_maps#index")
    end

    it "routes to #new" do
      get("/mini_maps/new").should route_to("mini_maps#new")
    end

    it "routes to #show" do
      get("/mini_maps/1").should route_to("mini_maps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mini_maps/1/edit").should route_to("mini_maps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mini_maps").should route_to("mini_maps#create")
    end

    it "routes to #update" do
      put("/mini_maps/1").should route_to("mini_maps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mini_maps/1").should route_to("mini_maps#destroy", :id => "1")
    end

  end
end
