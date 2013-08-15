require 'spec_helper'

describe "mini_map_cells/index" do
  before(:each) do
    assign(:mini_map_cells, [
      stub_model(MiniMapCell,
        :mini_map => nil,
        :x => 1,
        :y => 2,
        :terrain => nil,
        :sp_resource => nil,
        :construction => nil,
        :built_point => 3,
        :const_active_flg => false,
        :capital_flg => false
      ),
      stub_model(MiniMapCell,
        :mini_map => nil,
        :x => 1,
        :y => 2,
        :terrain => nil,
        :sp_resource => nil,
        :construction => nil,
        :built_point => 3,
        :const_active_flg => false,
        :capital_flg => false
      )
    ])
  end

  it "renders a list of mini_map_cells" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
