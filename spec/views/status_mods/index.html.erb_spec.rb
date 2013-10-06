require 'spec_helper'

describe "status_mods/index" do
  before(:each) do
    assign(:status_mods, [
      stub_model(StatusMod,
        :name => "Name",
        :hit_accuracy => 1,
        :d_range => 2,
        :x_range => 3,
        :hp_damage => 4,
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
      ),
      stub_model(StatusMod,
        :name => "Name",
        :hit_accuracy => 1,
        :d_range => 2,
        :x_range => 3,
        :hp_damage => 4,
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
      )
    ])
  end

  it "renders a list of status_mods" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
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
  end
end
