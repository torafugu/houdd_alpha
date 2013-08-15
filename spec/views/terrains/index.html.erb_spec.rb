require 'spec_helper'

describe "terrains/index" do
  before(:each) do
    assign(:terrains, [
      stub_model(Terrain,
        :symbol => "Symbol",
        :name => "Name",
        :food => 1,
        :production => 2,
        :money => 3,
        :frequency_rate => 4,
        :continuity_mod => 5
      ),
      stub_model(Terrain,
        :symbol => "Symbol",
        :name => "Name",
        :food => 1,
        :production => 2,
        :money => 3,
        :frequency_rate => 4,
        :continuity_mod => 5
      )
    ])
  end

  it "renders a list of terrains" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Symbol".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
