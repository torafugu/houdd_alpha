require 'spec_helper'

describe "item_infos/index" do
  before(:each) do
    assign(:item_infos, [
      stub_model(ItemInfo,
        :item_category => nil,
        :size => 1,
        :weight_level => 2,
        :name => "Name",
        :max_dp => 3,
        :rq_prod_point => 4,
        :research_level => 5
      ),
      stub_model(ItemInfo,
        :item_category => nil,
        :size => 1,
        :weight_level => 2,
        :name => "Name",
        :max_dp => 3,
        :rq_prod_point => 4,
        :research_level => 5
      )
    ])
  end

  it "renders a list of item_infos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
