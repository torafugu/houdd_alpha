require 'spec_helper'

describe "missions/edit" do
  before(:each) do
    @mission = assign(:mission, stub_model(Mission,
      :houdd_user => nil,
      :mini_map => nil,
      :category_symbol => "MyString",
      :mission_strategy => nil,
      :status_symbol => "MyString",
      :start_houdd_time => "9.99",
      :end_houdd_time => "9.99"
    ))
  end

  it "renders the edit mission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mission_path(@mission), "post" do
      assert_select "input#mission_houdd_user[name=?]", "mission[houdd_user]"
      assert_select "input#mission_mini_map[name=?]", "mission[mini_map]"
      assert_select "input#mission_category_symbol[name=?]", "mission[category_symbol]"
      assert_select "input#mission_mission_strategy[name=?]", "mission[mission_strategy]"
      assert_select "input#mission_status_symbol[name=?]", "mission[status_symbol]"
      assert_select "input#mission_start_houdd_time[name=?]", "mission[start_houdd_time]"
      assert_select "input#mission_end_houdd_time[name=?]", "mission[end_houdd_time]"
    end
  end
end
