require 'spec_helper'

describe "item_categories/edit" do
  before(:each) do
    @item_category = assign(:item_category, stub_model(ItemCategory,
      :type_sym => "MyString",
      :name => "MyString",
      :body_part => nil,
      :rq_slot_num => 1
    ))
  end

  it "renders the edit item_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_category_path(@item_category), "post" do
      assert_select "input#item_category_type_sym[name=?]", "item_category[type_sym]"
      assert_select "input#item_category_name[name=?]", "item_category[name]"
      assert_select "input#item_category_body_part[name=?]", "item_category[body_part]"
      assert_select "input#item_category_rq_slot_num[name=?]", "item_category[rq_slot_num]"
    end
  end
end
