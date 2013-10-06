require 'spec_helper'

describe "SkillInvs" do
  describe "GET /skill_invs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get skill_invs_path
      response.status.should be(200)
    end
  end
end
