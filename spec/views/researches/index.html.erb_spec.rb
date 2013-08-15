require 'spec_helper'

describe "researches/index" do
  before(:each) do
    assign(:researches, [
      stub_model(Research,
        :houdd_user => nil,
        :symbol => "Symbol",
        :level => 1,
        :allotment => 2,
        :invested_point => 3
      ),
      stub_model(Research,
        :houdd_user => nil,
        :symbol => "Symbol",
        :level => 1,
        :allotment => 2,
        :invested_point => 3
      )
    ])
  end

  it "renders a list of researches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Symbol".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
