require 'spec_helper'

describe "constructions/index" do
  before(:each) do
    assign(:constructions, [
      stub_model(Construction,
        :terrain => nil,
        :symbol => "Symbol",
        :name => "Name",
        :food => 1,
        :production => 2,
        :money => 3,
        :rq_prod_point => 4,
        :rq_days => 5
      ),
      stub_model(Construction,
        :terrain => nil,
        :symbol => "Symbol",
        :name => "Name",
        :food => 1,
        :production => 2,
        :money => 3,
        :rq_prod_point => 4,
        :rq_days => 5
      )
    ])
  end

  it "renders a list of constructions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Symbol".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
