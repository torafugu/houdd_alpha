require 'spec_helper'

describe "item_categories/index" do
  before(:each) do
    assign(:item_categories, [
      stub_model(ItemCategory,
        :type_sym => "Type Sym",
        :name => "Name",
        :body_part => nil,
        :rq_slot_num => 1
      ),
      stub_model(ItemCategory,
        :type_sym => "Type Sym",
        :name => "Name",
        :body_part => nil,
        :rq_slot_num => 1
      )
    ])
  end

  it "renders a list of item_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type Sym".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
