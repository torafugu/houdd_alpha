require 'spec_helper'

describe "map_item_invs/index" do
  before(:each) do
    assign(:map_item_invs, [
      stub_model(MapItemInv,
        :mini_map => nil,
        :item => nil
      ),
      stub_model(MapItemInv,
        :mini_map => nil,
        :item => nil
      )
    ])
  end

  it "renders a list of map_item_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
