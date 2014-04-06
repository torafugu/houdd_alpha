require "spec_helper"

describe TrialsController do
  describe "routing" do

    it "routes to #index" do
      get("/trials").should route_to("trials#index")
    end

    it "routes to #new" do
      get("/trials/new").should route_to("trials#new")
    end

    it "routes to #show" do
      get("/trials/1").should route_to("trials#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trials/1/edit").should route_to("trials#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trials").should route_to("trials#create")
    end

    it "routes to #update" do
      put("/trials/1").should route_to("trials#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trials/1").should route_to("trials#destroy", :id => "1")
    end

  end
end
