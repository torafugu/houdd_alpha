require 'spec_helper'

describe "SpResources" do
  describe "GET /sp_resources" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sp_resources_path
      response.status.should be(200)
    end
  end
end
