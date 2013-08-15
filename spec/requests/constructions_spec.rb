require 'spec_helper'

describe "Constructions" do
  describe "GET /constructions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get constructions_path
      response.status.should be(200)
    end
  end
end
