require "spec_helper"

describe DnasController do
  describe "routing" do

    it "routes to #index" do
      get("/dnas").should route_to("dnas#index")
    end

    it "routes to #new" do
      get("/dnas/new").should route_to("dnas#new")
    end

    it "routes to #show" do
      get("/dnas/1").should route_to("dnas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dnas/1/edit").should route_to("dnas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dnas").should route_to("dnas#create")
    end

    it "routes to #update" do
      put("/dnas/1").should route_to("dnas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dnas/1").should route_to("dnas#destroy", :id => "1")
    end

  end
end
