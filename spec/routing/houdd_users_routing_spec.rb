require "spec_helper"

describe HouddUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/houdd_users").should route_to("houdd_users#index")
    end

    it "routes to #new" do
      get("/houdd_users/new").should route_to("houdd_users#new")
    end

    it "routes to #show" do
      get("/houdd_users/1").should route_to("houdd_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/houdd_users/1/edit").should route_to("houdd_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/houdd_users").should route_to("houdd_users#create")
    end

    it "routes to #update" do
      put("/houdd_users/1").should route_to("houdd_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/houdd_users/1").should route_to("houdd_users#destroy", :id => "1")
    end

  end
end
