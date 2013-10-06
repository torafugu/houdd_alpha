require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :item_info => nil,
      :houdd_user => nil,
      :dp => 1,
      :quality => 1,
      :built_point => 1,
      :active_flg => false
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_path(@item), "post" do
      assert_select "input#item_item_info[name=?]", "item[item_info]"
      assert_select "input#item_houdd_user[name=?]", "item[houdd_user]"
      assert_select "input#item_dp[name=?]", "item[dp]"
      assert_select "input#item_quality[name=?]", "item[quality]"
      assert_select "input#item_built_point[name=?]", "item[built_point]"
      assert_select "input#item_active_flg[name=?]", "item[active_flg]"
    end
  end
end
