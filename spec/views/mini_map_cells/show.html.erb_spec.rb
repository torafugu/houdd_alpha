require 'spec_helper'

describe "mini_map_cells/show" do
  before(:each) do
    @mini_map_cell = assign(:mini_map_cell, stub_model(MiniMapCell,
      :mini_map => nil,
      :x => 1,
      :y => 2,
      :terrain => nil,
      :sp_resource => nil,
      :construction => nil,
      :built_point => 3,
      :const_active_flg => false,
      :capital_flg => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/3/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
