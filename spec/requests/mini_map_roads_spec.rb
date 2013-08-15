require 'spec_helper'

describe "MiniMapRoads" do
  describe "GET /mini_map_roads" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get mini_map_roads_path
      response.status.should be(200)
    end
  end
end
