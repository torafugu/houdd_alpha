require 'spec_helper'

describe "map_item_invs/show" do
  before(:each) do
    @map_item_inv = assign(:map_item_inv, stub_model(MapItemInv,
      :mini_map => nil,
      :item => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
