require 'spec_helper'

describe "item_sp_resource_invs/edit" do
  before(:each) do
    @item_sp_resource_inv = assign(:item_sp_resource_inv, stub_model(ItemSpResourceInv,
      :item_info => nil,
      :sp_resource => nil
    ))
  end

  it "renders the edit item_sp_resource_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_sp_resource_inv_path(@item_sp_resource_inv), "post" do
      assert_select "input#item_sp_resource_inv_item_info[name=?]", "item_sp_resource_inv[item_info]"
      assert_select "input#item_sp_resource_inv_sp_resource[name=?]", "item_sp_resource_inv[sp_resource]"
    end
  end
end
