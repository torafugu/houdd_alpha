require "spec_helper"

describe MiniMapRoadsController do
  describe "routing" do

    it "routes to #index" do
      get("/mini_map_roads").should route_to("mini_map_roads#index")
    end

    it "routes to #new" do
      get("/mini_map_roads/new").should route_to("mini_map_roads#new")
    end

    it "routes to #show" do
      get("/mini_map_roads/1").should route_to("mini_map_roads#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mini_map_roads/1/edit").should route_to("mini_map_roads#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mini_map_roads").should route_to("mini_map_roads#create")
    end

    it "routes to #update" do
      put("/mini_map_roads/1").should route_to("mini_map_roads#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mini_map_roads/1").should route_to("mini_map_roads#destroy", :id => "1")
    end

  end
end
