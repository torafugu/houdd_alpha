require 'spec_helper'

describe "MapItemInvs" do
  describe "GET /map_item_invs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get map_item_invs_path
      response.status.should be(200)
    end
  end
end
