require 'spec_helper'

describe "JobSkillInvs" do
  describe "GET /job_skill_invs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get job_skill_invs_path
      response.status.should be(200)
    end
  end
end
