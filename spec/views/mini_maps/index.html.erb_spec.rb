require 'spec_helper'

describe "mini_maps/index" do
  before(:each) do
    assign(:mini_maps, [
      stub_model(MiniMap,
        :houdd_user => nil,
        :name => "Name",
        :size => 1,
        :hq_flg => false,
        :type_symbol => "Type Symbol",
        :find_root_flg => false
      ),
      stub_model(MiniMap,
        :houdd_user => nil,
        :name => "Name",
        :size => 1,
        :hq_flg => false,
        :type_symbol => "Type Symbol",
        :find_root_flg => false
      )
    ])
  end

  it "renders a list of mini_maps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Type Symbol".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
