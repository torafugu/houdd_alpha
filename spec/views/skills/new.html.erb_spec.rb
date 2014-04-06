require 'spec_helper'

describe "skills/new" do
  before(:each) do
    assign(:skill, stub_model(Skill,
      :type_symbol => "MyString",
      :element_symbol => "MyString",
      :name => "MyString",
      :sp_cost => 1,
      :num_of_tgt => 1,
      :hit_accuracy => 1,
      :range => 1,
      :damage => 1,
      :heal => 1,
      :str_mod => 1.5,
      :dex_mod => 1.5,
      :con_mod => 1.5,
      :int_mod => 1.5,
      :wis_mod => 1.5,
      :cha_mod => 1.5,
      :ele_fw_mod => 1.5,
      :ele_ld_mod => 1.5,
      :phys_def_mod => 1.5,
      :skill_def_mod => 1.5,
      :duration => 1,
      :cast_cycle => 1,
      :research_level => 1
    ).as_new_record)
  end

  it "renders new skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skills_path, "post" do
      assert_select "input#skill_type_symbol[name=?]", "skill[type_symbol]"
      assert_select "input#skill_element_symbol[name=?]", "skill[element_symbol]"
      assert_select "input#skill_name[name=?]", "skill[name]"
      assert_select "input#skill_sp_cost[name=?]", "skill[sp_cost]"
      assert_select "input#skill_num_of_tgt[name=?]", "skill[num_of_tgt]"
      assert_select "input#skill_hit_accuracy[name=?]", "skill[hit_accuracy]"
      assert_select "input#skill_range[name=?]", "skill[range]"
      assert_select "input#skill_damage[name=?]", "skill[damage]"
      assert_select "input#skill_heal[name=?]", "skill[heal]"
      assert_select "input#skill_str_mod[name=?]", "skill[str_mod]"
      assert_select "input#skill_dex_mod[name=?]", "skill[dex_mod]"
      assert_select "input#skill_con_mod[name=?]", "skill[con_mod]"
      assert_select "input#skill_int_mod[name=?]", "skill[int_mod]"
      assert_select "input#skill_wis_mod[name=?]", "skill[wis_mod]"
      assert_select "input#skill_cha_mod[name=?]", "skill[cha_mod]"
      assert_select "input#skill_ele_fw_mod[name=?]", "skill[ele_fw_mod]"
      assert_select "input#skill_ele_ld_mod[name=?]", "skill[ele_ld_mod]"
      assert_select "input#skill_phys_def_mod[name=?]", "skill[phys_def_mod]"
      assert_select "input#skill_skill_def_mod[name=?]", "skill[skill_def_mod]"
      assert_select "input#skill_duration[name=?]", "skill[duration]"
      assert_select "input#skill_cast_cycle[name=?]", "skill[cast_cycle]"
      assert_select "input#skill_research_level[name=?]", "skill[research_level]"
    end
  end
end
