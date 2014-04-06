require 'spec_helper'

describe "job_skill_invs/edit" do
  before(:each) do
    @job_skill_inv = assign(:job_skill_inv, stub_model(JobSkillInv,
      :skill => nil,
      :job => nil
    ))
  end

  it "renders the edit job_skill_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_skill_inv_path(@job_skill_inv), "post" do
      assert_select "input#job_skill_inv_skill[name=?]", "job_skill_inv[skill]"
      assert_select "input#job_skill_inv_job[name=?]", "job_skill_inv[job]"
    end
  end
end
