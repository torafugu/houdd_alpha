require "spec_helper"

describe FortressCellsController do
  describe "routing" do

    it "routes to #index" do
      get("/fortress_cells").should route_to("fortress_cells#index")
    end

    it "routes to #new" do
      get("/fortress_cells/new").should route_to("fortress_cells#new")
    end

    it "routes to #show" do
      get("/fortress_cells/1").should route_to("fortress_cells#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fortress_cells/1/edit").should route_to("fortress_cells#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fortress_cells").should route_to("fortress_cells#create")
    end

    it "routes to #update" do
      put("/fortress_cells/1").should route_to("fortress_cells#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fortress_cells/1").should route_to("fortress_cells#destroy", :id => "1")
    end

  end
end
