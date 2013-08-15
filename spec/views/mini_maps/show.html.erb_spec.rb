require 'spec_helper'

describe "mini_maps/show" do
  before(:each) do
    @mini_map = assign(:mini_map, stub_model(MiniMap,
      :houdd_user => nil,
      :name => "Name",
      :size => 1,
      :hq_flg => false,
      :type_symbol => "Type Symbol",
      :find_root_flg => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/Type Symbol/)
    rendered.should match(/false/)
  end
end
