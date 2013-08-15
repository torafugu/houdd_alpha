require "spec_helper"

describe SpResourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/sp_resources").should route_to("sp_resources#index")
    end

    it "routes to #new" do
      get("/sp_resources/new").should route_to("sp_resources#new")
    end

    it "routes to #show" do
      get("/sp_resources/1").should route_to("sp_resources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sp_resources/1/edit").should route_to("sp_resources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sp_resources").should route_to("sp_resources#create")
    end

    it "routes to #update" do
      put("/sp_resources/1").should route_to("sp_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sp_resources/1").should route_to("sp_resources#destroy", :id => "1")
    end

  end
end
