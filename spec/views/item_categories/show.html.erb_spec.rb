require 'spec_helper'

describe "item_categories/show" do
  before(:each) do
    @item_category = assign(:item_category, stub_model(ItemCategory,
      :type_sym => "Type Sym",
      :name => "Name",
      :body_part => nil,
      :rq_slot_num => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type Sym/)
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
