require "spec_helper"

describe StatusModsController do
  describe "routing" do

    it "routes to #index" do
      get("/status_mods").should route_to("status_mods#index")
    end

    it "routes to #new" do
      get("/status_mods/new").should route_to("status_mods#new")
    end

    it "routes to #show" do
      get("/status_mods/1").should route_to("status_mods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/status_mods/1/edit").should route_to("status_mods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/status_mods").should route_to("status_mods#create")
    end

    it "routes to #update" do
      put("/status_mods/1").should route_to("status_mods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/status_mods/1").should route_to("status_mods#destroy", :id => "1")
    end

  end
end
