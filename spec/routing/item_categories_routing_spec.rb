require "spec_helper"

describe ItemCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/item_categories").should route_to("item_categories#index")
    end

    it "routes to #new" do
      get("/item_categories/new").should route_to("item_categories#new")
    end

    it "routes to #show" do
      get("/item_categories/1").should route_to("item_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/item_categories/1/edit").should route_to("item_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/item_categories").should route_to("item_categories#create")
    end

    it "routes to #update" do
      put("/item_categories/1").should route_to("item_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/item_categories/1").should route_to("item_categories#destroy", :id => "1")
    end

  end
end
