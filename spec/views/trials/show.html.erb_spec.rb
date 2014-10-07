require 'spec_helper'

describe "trials/show" do
  before(:each) do
    @trial = assign(:trial, stub_model(Trial,
      :mini_map => nil,
      :map_name => "Map Name",
      :guard_mission_id => 1,
      :intruder_mission_id => 2,
      :occurred_at => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Map Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
