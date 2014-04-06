require 'spec_helper'

describe "jobs/edit" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :type_symbol => "MyString",
      :name => "MyString",
      :growth_penalty => 1.5,
      :wepon_lvl => 1,
      :armor_lvl => 1,
      :str_mod => 1.5,
      :dex_mod => 1.5,
      :con_mod => 1.5,
      :int_mod => 1.5,
      :wis_mod => 1.5,
      :cha_mod => 1.5,
      :ele_fw_mod => 1.5,
      :ele_ld_mod => 1.5,
      :phys_def_mod => 1.5,
      :skill_def_mod => 1.5
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_path(@job), "post" do
      assert_select "input#job_type_symbol[name=?]", "job[type_symbol]"
      assert_select "input#job_name[name=?]", "job[name]"
      assert_select "input#job_growth_penalty[name=?]", "job[growth_penalty]"
      assert_select "input#job_wepon_lvl[name=?]", "job[wepon_lvl]"
      assert_select "input#job_armor_lvl[name=?]", "job[armor_lvl]"
      assert_select "input#job_str_mod[name=?]", "job[str_mod]"
      assert_select "input#job_dex_mod[name=?]", "job[dex_mod]"
      assert_select "input#job_con_mod[name=?]", "job[con_mod]"
      assert_select "input#job_int_mod[name=?]", "job[int_mod]"
      assert_select "input#job_wis_mod[name=?]", "job[wis_mod]"
      assert_select "input#job_cha_mod[name=?]", "job[cha_mod]"
      assert_select "input#job_ele_fw_mod[name=?]", "job[ele_fw_mod]"
      assert_select "input#job_ele_ld_mod[name=?]", "job[ele_ld_mod]"
      assert_select "input#job_phys_def_mod[name=?]", "job[phys_def_mod]"
      assert_select "input#job_skill_def_mod[name=?]", "job[skill_def_mod]"
    end
  end
end
