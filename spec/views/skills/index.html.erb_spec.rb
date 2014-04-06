require 'spec_helper'

describe "skills/index" do
  before(:each) do
    assign(:skills, [
      stub_model(Skill,
        :type_symbol => "Type Symbol",
        :element_symbol => "Element Symbol",
        :name => "Name",
        :sp_cost => 1,
        :num_of_tgt => 2,
        :hit_accuracy => 3,
        :range => 4,
        :damage => 5,
        :heal => 6,
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
        :duration => 7,
        :cast_cycle => 8,
        :research_level => 9
      ),
      stub_model(Skill,
        :type_symbol => "Type Symbol",
        :element_symbol => "Element Symbol",
        :name => "Name",
        :sp_cost => 1,
        :num_of_tgt => 2,
        :hit_accuracy => 3,
        :range => 4,
        :damage => 5,
        :heal => 6,
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
        :duration => 7,
        :cast_cycle => 8,
        :research_level => 9
      )
    ])
  end

  it "renders a list of skills" do
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
    assert_select "tr>td", :text => 6.to_s, :count => 2
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
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
  end
end
