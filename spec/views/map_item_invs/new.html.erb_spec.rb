require 'spec_helper'

describe "map_item_invs/new" do
  before(:each) do
    assign(:map_item_inv, stub_model(MapItemInv,
      :mini_map => nil,
      :item => nil
    ).as_new_record)
  end

  it "renders new map_item_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", map_item_invs_path, "post" do
      assert_select "input#map_item_inv_mini_map[name=?]", "map_item_inv[mini_map]"
      assert_select "input#map_item_inv_item[name=?]", "map_item_inv[item]"
    end
  end
end
