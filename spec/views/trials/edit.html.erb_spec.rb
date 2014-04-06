require 'spec_helper'

describe "trials/edit" do
  before(:each) do
    @trial = assign(:trial, stub_model(Trial,
      :mini_map => nil,
      :map_name => "MyString",
      :guard_mission_id => 1,
      :intruder_mission_id => 1,
      :occured_at => 1
    ))
  end

  it "renders the edit trial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trial_path(@trial), "post" do
      assert_select "input#trial_mini_map[name=?]", "trial[mini_map]"
      assert_select "input#trial_map_name[name=?]", "trial[map_name]"
      assert_select "input#trial_guard_mission_id[name=?]", "trial[guard_mission_id]"
      assert_select "input#trial_intruder_mission_id[name=?]", "trial[intruder_mission_id]"
      assert_select "input#trial_occured_at[name=?]", "trial[occured_at]"
    end
  end
end
