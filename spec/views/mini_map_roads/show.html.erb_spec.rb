require 'spec_helper'

describe "mini_map_roads/show" do
  before(:each) do
    @mini_map_road = assign(:mini_map_road, stub_model(MiniMapRoad,
      :start_mini_map_id => 1,
      :end_mini_map_id => 2,
      :distance => 3,
      :level => 4,
      :built_point => 5,
      :active_flg => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/false/)
  end
end
