require "spec_helper"

describe MapItemInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/map_item_invs").should route_to("map_item_invs#index")
    end

    it "routes to #new" do
      get("/map_item_invs/new").should route_to("map_item_invs#new")
    end

    it "routes to #show" do
      get("/map_item_invs/1").should route_to("map_item_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/map_item_invs/1/edit").should route_to("map_item_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/map_item_invs").should route_to("map_item_invs#create")
    end

    it "routes to #update" do
      put("/map_item_invs/1").should route_to("map_item_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/map_item_invs/1").should route_to("map_item_invs#destroy", :id => "1")
    end

  end
end
