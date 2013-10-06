require "spec_helper"

describe BodyPartsController do
  describe "routing" do

    it "routes to #index" do
      get("/body_parts").should route_to("body_parts#index")
    end

    it "routes to #new" do
      get("/body_parts/new").should route_to("body_parts#new")
    end

    it "routes to #show" do
      get("/body_parts/1").should route_to("body_parts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/body_parts/1/edit").should route_to("body_parts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/body_parts").should route_to("body_parts#create")
    end

    it "routes to #update" do
      put("/body_parts/1").should route_to("body_parts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/body_parts/1").should route_to("body_parts#destroy", :id => "1")
    end

  end
end
