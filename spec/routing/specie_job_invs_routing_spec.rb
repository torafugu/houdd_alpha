require "spec_helper"

describe SpecieJobInvsController do
  describe "routing" do

    it "routes to #index" do
      get("/specie_job_invs").should route_to("specie_job_invs#index")
    end

    it "routes to #new" do
      get("/specie_job_invs/new").should route_to("specie_job_invs#new")
    end

    it "routes to #show" do
      get("/specie_job_invs/1").should route_to("specie_job_invs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/specie_job_invs/1/edit").should route_to("specie_job_invs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/specie_job_invs").should route_to("specie_job_invs#create")
    end

    it "routes to #update" do
      put("/specie_job_invs/1").should route_to("specie_job_invs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/specie_job_invs/1").should route_to("specie_job_invs#destroy", :id => "1")
    end

  end
end
