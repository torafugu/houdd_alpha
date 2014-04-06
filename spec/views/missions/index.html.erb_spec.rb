require 'spec_helper'

describe "missions/index" do
  before(:each) do
    assign(:missions, [
      stub_model(Mission,
        :houdd_user => nil,
        :mini_map => nil,
        :category_symbol => "Category Symbol",
        :mission_strategy => nil,
        :status_symbol => "Status Symbol",
        :start_houdd_time => "9.99",
        :end_houdd_time => "9.99"
      ),
      stub_model(Mission,
        :houdd_user => nil,
        :mini_map => nil,
        :category_symbol => "Category Symbol",
        :mission_strategy => nil,
        :status_symbol => "Status Symbol",
        :start_houdd_time => "9.99",
        :end_houdd_time => "9.99"
      )
    ])
  end

  it "renders a list of missions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Category Symbol".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Status Symbol".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
