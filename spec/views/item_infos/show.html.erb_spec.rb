require 'spec_helper'

describe "item_infos/show" do
  before(:each) do
    @item_info = assign(:item_info, stub_model(ItemInfo,
      :item_category => nil,
      :size => 1,
      :weight_level => 2,
      :name => "Name",
      :max_dp => 3,
      :rq_prod_point => 4,
      :research_level => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
