require 'spec_helper'

describe "genes/index" do
  before(:each) do
    assign(:genes, [
      stub_model(Gene,
        :specie => nil,
        :dominance_flg => false,
        :prolificacy_mod => 1.5,
        :longevity_mod => 1.5,
        :growth_mod => 1.5,
        :food_cost_mod => 1.5,
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
      stub_model(Gene,
        :specie => nil,
        :dominance_flg => false,
        :prolificacy_mod => 1.5,
        :longevity_mod => 1.5,
        :growth_mod => 1.5,
        :food_cost_mod => 1.5,
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

  it "renders a list of genes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
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
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
