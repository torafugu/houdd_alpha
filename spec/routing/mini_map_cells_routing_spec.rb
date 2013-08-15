require "spec_helper"

describe MiniMapCellsController do
  describe "routing" do

    it "routes to #index" do
      get("/mini_map_cells").should route_to("mini_map_cells#index")
    end

    it "routes to #new" do
      get("/mini_map_cells/new").should route_to("mini_map_cells#new")
    end

    it "routes to #show" do
      get("/mini_map_cells/1").should route_to("mini_map_cells#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mini_map_cells/1/edit").should route_to("mini_map_cells#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mini_map_cells").should route_to("mini_map_cells#create")
    end

    it "routes to #update" do
      put("/mini_map_cells/1").should route_to("mini_map_cells#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mini_map_cells/1").should route_to("mini_map_cells#destroy", :id => "1")
    end

  end
end
