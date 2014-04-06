require 'spec_helper'

describe "item_infos/index" do
  before(:each) do
    assign(:item_infos, [
      stub_model(ItemInfo,
        :type_symbol => "Type Symbol",
        :element_symbol => "Element Symbol",
        :name => "Name",
        :num_of_tgt => 1,
        :hit_accuracy => 2,
        :range => 3,
        :damage => 4,
        :heal => 5,
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
        :duration => 6,
        :family => nil,
        :weight_level => 7,
        :max_dp => 8,
        :rq_prod_point => 9,
        :atk_cycle => 10,
        :research_level => 11
      ),
      stub_model(ItemInfo,
        :type_symbol => "Type Symbol",
        :element_symbol => "Element Symbol",
        :name => "Name",
        :num_of_tgt => 1,
        :hit_accuracy => 2,
        :range => 3,
        :damage => 4,
        :heal => 5,
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
        :duration => 6,
        :family => nil,
        :weight_level => 7,
        :max_dp => 8,
        :rq_prod_point => 9,
        :atk_cycle => 10,
        :research_level => 11
      )
    ])
  end

  it "renders a list of item_infos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type Symbol".to_s, :count => 2
    assert_select "tr>td", :text => "Element Symbol".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
