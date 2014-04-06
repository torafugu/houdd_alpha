require 'spec_helper'

describe "job_skill_invs/index" do
  before(:each) do
    assign(:job_skill_invs, [
      stub_model(JobSkillInv,
        :skill => nil,
        :job => nil
      ),
      stub_model(JobSkillInv,
        :skill => nil,
        :job => nil
      )
    ])
  end

  it "renders a list of job_skill_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
