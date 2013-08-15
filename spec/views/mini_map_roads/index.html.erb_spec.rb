require 'spec_helper'

describe "mini_map_roads/index" do
  before(:each) do
    assign(:mini_map_roads, [
      stub_model(MiniMapRoad,
        :start_mini_map_id => 1,
        :end_mini_map_id => 2,
        :distance => 3,
        :level => 4,
        :built_point => 5,
        :active_flg => false
      ),
      stub_model(MiniMapRoad,
        :start_mini_map_id => 1,
        :end_mini_map_id => 2,
        :distance => 3,
        :level => 4,
        :built_point => 5,
        :active_flg => false
      )
    ])
  end

  it "renders a list of mini_map_roads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
