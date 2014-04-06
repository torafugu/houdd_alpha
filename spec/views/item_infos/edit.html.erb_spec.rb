require 'spec_helper'

describe "item_infos/edit" do
  before(:each) do
    @item_info = assign(:item_info, stub_model(ItemInfo,
      :type_symbol => "MyString",
      :element_symbol => "MyString",
      :name => "MyString",
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
      :family => nil,
      :weight_level => 1,
      :max_dp => 1,
      :rq_prod_point => 1,
      :atk_cycle => 1,
      :research_level => 1
    ))
  end

  it "renders the edit item_info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_info_path(@item_info), "post" do
      assert_select "input#item_info_type_symbol[name=?]", "item_info[type_symbol]"
      assert_select "input#item_info_element_symbol[name=?]", "item_info[element_symbol]"
      assert_select "input#item_info_name[name=?]", "item_info[name]"
      assert_select "input#item_info_num_of_tgt[name=?]", "item_info[num_of_tgt]"
      assert_select "input#item_info_hit_accuracy[name=?]", "item_info[hit_accuracy]"
      assert_select "input#item_info_range[name=?]", "item_info[range]"
      assert_select "input#item_info_damage[name=?]", "item_info[damage]"
      assert_select "input#item_info_heal[name=?]", "item_info[heal]"
      assert_select "input#item_info_str_mod[name=?]", "item_info[str_mod]"
      assert_select "input#item_info_dex_mod[name=?]", "item_info[dex_mod]"
      assert_select "input#item_info_con_mod[name=?]", "item_info[con_mod]"
      assert_select "input#item_info_int_mod[name=?]", "item_info[int_mod]"
      assert_select "input#item_info_wis_mod[name=?]", "item_info[wis_mod]"
      assert_select "input#item_info_cha_mod[name=?]", "item_info[cha_mod]"
      assert_select "input#item_info_ele_fw_mod[name=?]", "item_info[ele_fw_mod]"
      assert_select "input#item_info_ele_ld_mod[name=?]", "item_info[ele_ld_mod]"
      assert_select "input#item_info_phys_def_mod[name=?]", "item_info[phys_def_mod]"
      assert_select "input#item_info_skill_def_mod[name=?]", "item_info[skill_def_mod]"
      assert_select "input#item_info_duration[name=?]", "item_info[duration]"
      assert_select "input#item_info_family[name=?]", "item_info[family]"
      assert_select "input#item_info_weight_level[name=?]", "item_info[weight_level]"
      assert_select "input#item_info_max_dp[name=?]", "item_info[max_dp]"
      assert_select "input#item_info_rq_prod_point[name=?]", "item_info[rq_prod_point]"
      assert_select "input#item_info_atk_cycle[name=?]", "item_info[atk_cycle]"
      assert_select "input#item_info_research_level[name=?]", "item_info[research_level]"
    end
  end
end
