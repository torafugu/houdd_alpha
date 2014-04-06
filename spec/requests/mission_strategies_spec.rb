require 'spec_helper'

describe "MissionStrategies" do
  describe "GET /mission_strategies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get mission_strategies_path
      response.status.should be(200)
    end
  end
end
