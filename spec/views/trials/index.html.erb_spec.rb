require 'spec_helper'

describe "trials/index" do
  before(:each) do
    assign(:trials, [
      stub_model(Trial,
        :mini_map => nil,
        :map_name => "Map Name",
        :guard_mission_id => 1,
        :intruder_mission_id => 2,
        :occured_at => 3
      ),
      stub_model(Trial,
        :mini_map => nil,
        :map_name => "Map Name",
        :guard_mission_id => 1,
        :intruder_mission_id => 2,
        :occured_at => 3
      )
    ])
  end

  it "renders a list of trials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Map Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
