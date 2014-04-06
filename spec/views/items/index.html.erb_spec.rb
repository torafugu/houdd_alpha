require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :item_info => nil,
        :houdd_user => nil,
        :mob => nil,
        :dp => 1,
        :quality => 2,
        :built_point => 3,
        :active_flg => false
      ),
      stub_model(Item,
        :item_info => nil,
        :houdd_user => nil,
        :mob => nil,
        :dp => 1,
        :quality => 2,
        :built_point => 3,
        :active_flg => false
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
