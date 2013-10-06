require 'spec_helper'

describe "item_infos/new" do
  before(:each) do
    assign(:item_info, stub_model(ItemInfo,
      :item_category => nil,
      :size => 1,
      :weight_level => 1,
      :name => "MyString",
      :max_dp => 1,
      :rq_prod_point => 1,
      :research_level => 1
    ).as_new_record)
  end

  it "renders new item_info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_infos_path, "post" do
      assert_select "input#item_info_item_category[name=?]", "item_info[item_category]"
      assert_select "input#item_info_size[name=?]", "item_info[size]"
      assert_select "input#item_info_weight_level[name=?]", "item_info[weight_level]"
      assert_select "input#item_info_name[name=?]", "item_info[name]"
      assert_select "input#item_info_max_dp[name=?]", "item_info[max_dp]"
      assert_select "input#item_info_rq_prod_point[name=?]", "item_info[rq_prod_point]"
      assert_select "input#item_info_research_level[name=?]", "item_info[research_level]"
    end
  end
end
