require "spec_helper"

describe GenesController do
  describe "routing" do

    it "routes to #index" do
      get("/genes").should route_to("genes#index")
    end

    it "routes to #new" do
      get("/genes/new").should route_to("genes#new")
    end

    it "routes to #show" do
      get("/genes/1").should route_to("genes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/genes/1/edit").should route_to("genes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/genes").should route_to("genes#create")
    end

    it "routes to #update" do
      put("/genes/1").should route_to("genes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/genes/1").should route_to("genes#destroy", :id => "1")
    end

  end
end
