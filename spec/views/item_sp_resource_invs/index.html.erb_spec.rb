require 'spec_helper'

describe "item_sp_resource_invs/index" do
  before(:each) do
    assign(:item_sp_resource_invs, [
      stub_model(ItemSpResourceInv,
        :item_info => nil,
        :sp_resource => nil
      ),
      stub_model(ItemSpResourceInv,
        :item_info => nil,
        :sp_resource => nil
      )
    ])
  end

  it "renders a list of item_sp_resource_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
