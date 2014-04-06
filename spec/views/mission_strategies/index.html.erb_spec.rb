require 'spec_helper'

describe "mission_strategies/index" do
  before(:each) do
    assign(:mission_strategies, [
      stub_model(MissionStrategy,
        :houdd_user => nil,
        :name => "Name",
        :script => "MyText"
      ),
      stub_model(MissionStrategy,
        :houdd_user => nil,
        :name => "Name",
        :script => "MyText"
      )
    ])
  end

  it "renders a list of mission_strategies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
