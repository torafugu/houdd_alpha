require "spec_helper"

describe ConstructionsController do
  describe "routing" do

    it "routes to #index" do
      get("/constructions").should route_to("constructions#index")
    end

    it "routes to #new" do
      get("/constructions/new").should route_to("constructions#new")
    end

    it "routes to #show" do
      get("/constructions/1").should route_to("constructions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/constructions/1/edit").should route_to("constructions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/constructions").should route_to("constructions#create")
    end

    it "routes to #update" do
      put("/constructions/1").should route_to("constructions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/constructions/1").should route_to("constructions#destroy", :id => "1")
    end

  end
end
