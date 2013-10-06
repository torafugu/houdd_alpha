require 'spec_helper'

describe "StatusModInvs" do
  describe "GET /status_mod_invs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get status_mod_invs_path
      response.status.should be(200)
    end
  end
end
