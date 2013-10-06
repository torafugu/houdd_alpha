require "spec_helper"

describe ItemSpResourceInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/item_sp_resource_invs").should route_to("item_sp_resource_invs#index")
    end

    it "routes to #new" do
      get("/item_sp_resource_invs/new").should route_to("item_sp_resource_invs#new")
    end

    it "routes to #show" do
      get("/item_sp_resource_invs/1").should route_to("item_sp_resource_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/item_sp_resource_invs/1/edit").should route_to("item_sp_resource_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/item_sp_resource_invs").should route_to("item_sp_resource_invs#create")
    end

    it "routes to #update" do
      put("/item_sp_resource_invs/1").should route_to("item_sp_resource_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/item_sp_resource_invs/1").should route_to("item_sp_resource_invs#destroy", :id => "1")
    end

  end
end
