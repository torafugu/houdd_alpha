require 'spec_helper'

describe "item_sp_resource_invs/new" do
  before(:each) do
    assign(:item_sp_resource_inv, stub_model(ItemSpResourceInv,
      :item_info => nil,
      :sp_resource => nil
    ).as_new_record)
  end

  it "renders new item_sp_resource_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_sp_resource_invs_path, "post" do
      assert_select "input#item_sp_resource_inv_item_info[name=?]", "item_sp_resource_inv[item_info]"
      assert_select "input#item_sp_resource_inv_sp_resource[name=?]", "item_sp_resource_inv[sp_resource]"
    end
  end
end
