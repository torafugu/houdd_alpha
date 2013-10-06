require 'spec_helper'

describe "status_mods/new" do
  before(:each) do
    assign(:status_mod, stub_model(StatusMod,
      :name => "MyString",
      :hit_accuracy => 1,
      :d_range => 1,
      :x_range => 1,
      :hp_damage => 1,
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
    ).as_new_record)
  end

  it "renders new status_mod form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", status_mods_path, "post" do
      assert_select "input#status_mod_name[name=?]", "status_mod[name]"
      assert_select "input#status_mod_hit_accuracy[name=?]", "status_mod[hit_accuracy]"
      assert_select "input#status_mod_d_range[name=?]", "status_mod[d_range]"
      assert_select "input#status_mod_x_range[name=?]", "status_mod[x_range]"
      assert_select "input#status_mod_hp_damage[name=?]", "status_mod[hp_damage]"
      assert_select "input#status_mod_str_mod[name=?]", "status_mod[str_mod]"
      assert_select "input#status_mod_dex_mod[name=?]", "status_mod[dex_mod]"
      assert_select "input#status_mod_con_mod[name=?]", "status_mod[con_mod]"
      assert_select "input#status_mod_int_mod[name=?]", "status_mod[int_mod]"
      assert_select "input#status_mod_wis_mod[name=?]", "status_mod[wis_mod]"
      assert_select "input#status_mod_cha_mod[name=?]", "status_mod[cha_mod]"
      assert_select "input#status_mod_ele_fw_mod[name=?]", "status_mod[ele_fw_mod]"
      assert_select "input#status_mod_ele_ld_mod[name=?]", "status_mod[ele_ld_mod]"
      assert_select "input#status_mod_phys_def_mod[name=?]", "status_mod[phys_def_mod]"
      assert_select "input#status_mod_skill_def_mod[name=?]", "status_mod[skill_def_mod]"
    end
  end
end
