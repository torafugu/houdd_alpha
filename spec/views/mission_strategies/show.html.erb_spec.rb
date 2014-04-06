require 'spec_helper'

describe "mission_strategies/show" do
  before(:each) do
    @mission_strategy = assign(:mission_strategy, stub_model(MissionStrategy,
      :houdd_user => nil,
      :name => "Name",
      :script => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
