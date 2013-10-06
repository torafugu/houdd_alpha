require "spec_helper"

describe ItemInfosController do
  describe "routing" do

    it "routes to #index" do
      get("/item_infos").should route_to("item_infos#index")
    end

    it "routes to #new" do
      get("/item_infos/new").should route_to("item_infos#new")
    end

    it "routes to #show" do
      get("/item_infos/1").should route_to("item_infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/item_infos/1/edit").should route_to("item_infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/item_infos").should route_to("item_infos#create")
    end

    it "routes to #update" do
      put("/item_infos/1").should route_to("item_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/item_infos/1").should route_to("item_infos#destroy", :id => "1")
    end

  end
end
