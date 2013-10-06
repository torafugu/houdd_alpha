require "spec_helper"

describe SkillCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/skill_categories").should route_to("skill_categories#index")
    end

    it "routes to #new" do
      get("/skill_categories/new").should route_to("skill_categories#new")
    end

    it "routes to #show" do
      get("/skill_categories/1").should route_to("skill_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/skill_categories/1/edit").should route_to("skill_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/skill_categories").should route_to("skill_categories#create")
    end

    it "routes to #update" do
      put("/skill_categories/1").should route_to("skill_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/skill_categories/1").should route_to("skill_categories#destroy", :id => "1")
    end

  end
end
