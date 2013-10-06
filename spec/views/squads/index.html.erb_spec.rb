require 'spec_helper'

describe "squads/index" do
  before(:each) do
    assign(:squads, [
      stub_model(Squad,
        :houdd_user => nil,
        :mini_map => nil,
        :name => "Name"
      ),
      stub_model(Squad,
        :houdd_user => nil,
        :mini_map => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of squads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
