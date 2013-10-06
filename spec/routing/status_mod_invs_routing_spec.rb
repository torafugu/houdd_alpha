require "spec_helper"

describe StatusModInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/status_mod_invs").should route_to("status_mod_invs#index")
    end

    it "routes to #new" do
      get("/status_mod_invs/new").should route_to("status_mod_invs#new")
    end

    it "routes to #show" do
      get("/status_mod_invs/1").should route_to("status_mod_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/status_mod_invs/1/edit").should route_to("status_mod_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/status_mod_invs").should route_to("status_mod_invs#create")
    end

    it "routes to #update" do
      put("/status_mod_invs/1").should route_to("status_mod_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/status_mod_invs/1").should route_to("status_mod_invs#destroy", :id => "1")
    end

  end
end
