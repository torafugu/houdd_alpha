require 'spec_helper'

describe "mission_strategies/edit" do
  before(:each) do
    @mission_strategy = assign(:mission_strategy, stub_model(MissionStrategy,
      :houdd_user => nil,
      :name => "MyString",
      :script => "MyText"
    ))
  end

  it "renders the edit mission_strategy form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mission_strategy_path(@mission_strategy), "post" do
      assert_select "input#mission_strategy_houdd_user[name=?]", "mission_strategy[houdd_user]"
      assert_select "input#mission_strategy_name[name=?]", "mission_strategy[name]"
      assert_select "textarea#mission_strategy_script[name=?]", "mission_strategy[script]"
    end
  end
end
