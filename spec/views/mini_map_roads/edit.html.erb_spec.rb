require 'spec_helper'

describe "mini_map_roads/edit" do
  before(:each) do
    @mini_map_road = assign(:mini_map_road, stub_model(MiniMapRoad,
      :start_mini_map_id => 1,
      :end_mini_map_id => 1,
      :distance => 1,
      :level => 1,
      :built_point => 1,
      :active_flg => false
    ))
  end

  it "renders the edit mini_map_road form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mini_map_road_path(@mini_map_road), "post" do
      assert_select "input#mini_map_road_start_mini_map_id[name=?]", "mini_map_road[start_mini_map_id]"
      assert_select "input#mini_map_road_end_mini_map_id[name=?]", "mini_map_road[end_mini_map_id]"
      assert_select "input#mini_map_road_distance[name=?]", "mini_map_road[distance]"
      assert_select "input#mini_map_road_level[name=?]", "mini_map_road[level]"
      assert_select "input#mini_map_road_built_point[name=?]", "mini_map_road[built_point]"
      assert_select "input#mini_map_road_active_flg[name=?]", "mini_map_road[active_flg]"
    end
  end
end
