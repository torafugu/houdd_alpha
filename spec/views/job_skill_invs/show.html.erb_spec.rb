require 'spec_helper'

describe "job_skill_invs/show" do
  before(:each) do
    @job_skill_inv = assign(:job_skill_inv, stub_model(JobSkillInv,
      :skill => nil,
      :job => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
