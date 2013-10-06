require 'spec_helper'

describe "item_sp_resource_invs/show" do
  before(:each) do
    @item_sp_resource_inv = assign(:item_sp_resource_inv, stub_model(ItemSpResourceInv,
      :item_info => nil,
      :sp_resource => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
