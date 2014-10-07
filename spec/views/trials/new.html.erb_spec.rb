require 'spec_helper'

describe "trials/new" do
  before(:each) do
    assign(:trial, stub_model(Trial,
      :mini_map => nil,
      :map_name => "MyString",
      :guard_mission_id => 1,
      :intruder_mission_id => 1,
      :occurred_at => 1
    ).as_new_record)
  end

  it "renders new trial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trials_path, "post" do
      assert_select "input#trial_mini_map[name=?]", "trial[mini_map]"
      assert_select "input#trial_map_name[name=?]", "trial[map_name]"
      assert_select "input#trial_guard_mission_id[name=?]", "trial[guard_mission_id]"
      assert_select "input#trial_intruder_mission_id[name=?]", "trial[intruder_mission_id]"
      assert_select "input#trial_occurred_at[name=?]", "trial[occurred_at]"
    end
  end
end
