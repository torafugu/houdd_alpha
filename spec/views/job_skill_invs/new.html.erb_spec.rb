require 'spec_helper'

describe "job_skill_invs/new" do
  before(:each) do
    assign(:job_skill_inv, stub_model(JobSkillInv,
      :skill => nil,
      :job => nil
    ).as_new_record)
  end

  it "renders new job_skill_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_skill_invs_path, "post" do
      assert_select "input#job_skill_inv_skill[name=?]", "job_skill_inv[skill]"
      assert_select "input#job_skill_inv_job[name=?]", "job_skill_inv[job]"
    end
  end
end
