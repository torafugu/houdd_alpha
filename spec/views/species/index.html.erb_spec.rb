require 'spec_helper'

describe "species/index" do
  before(:each) do
    assign(:species, [
      stub_model(Specie,
        :family => nil,
        :name => "Name",
        :longevity => 1,
        :prolificacy => 1.5,
        :growth_rate => 1.5,
        :food_cost => 2,
        :str => 3,
        :dex => 4,
        :con => 5,
        :int => 6,
        :wis => 7,
        :cha => 8,
        :mutation_rate => 1.5,
        :phys_def => 9,
        :skill_def => 10,
        :ele_fw => 11,
        :ele_ld => 12
      ),
      stub_model(Specie,
        :family => nil,
        :name => "Name",
        :longevity => 1,
        :prolificacy => 1.5,
        :growth_rate => 1.5,
        :food_cost => 2,
        :str => 3,
        :dex => 4,
        :con => 5,
        :int => 6,
        :wis => 7,
        :cha => 8,
        :mutation_rate => 1.5,
        :phys_def => 9,
        :skill_def => 10,
        :ele_fw => 11,
        :ele_ld => 12
      )
    ])
  end

  it "renders a list of species" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
  end
end
