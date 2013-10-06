require 'spec_helper'

describe "mini_map_cells/edit" do
  before(:each) do
    @mini_map_cell = assign(:mini_map_cell, stub_model(MiniMapCell,
      :mini_map => nil,
      :x => 1,
      :y => 1,
      :terrain => nil,
      :sp_resource => nil,
      :construction => nil,
      :built_point => 1,
      :active_flg => false,
      :capital_flg => false
    ))
  end

  it "renders the edit mini_map_cell form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mini_map_cell_path(@mini_map_cell), "post" do
      assert_select "input#mini_map_cell_mini_map[name=?]", "mini_map_cell[mini_map]"
      assert_select "input#mini_map_cell_x[name=?]", "mini_map_cell[x]"
      assert_select "input#mini_map_cell_y[name=?]", "mini_map_cell[y]"
      assert_select "input#mini_map_cell_terrain[name=?]", "mini_map_cell[terrain]"
      assert_select "input#mini_map_cell_sp_resource[name=?]", "mini_map_cell[sp_resource]"
      assert_select "input#mini_map_cell_construction[name=?]", "mini_map_cell[construction]"
      assert_select "input#mini_map_cell_built_point[name=?]", "mini_map_cell[built_point]"
      assert_select "input#mini_map_cell_active_flg[name=?]", "mini_map_cell[active_flg]"
      assert_select "input#mini_map_cell_capital_flg[name=?]", "mini_map_cell[capital_flg]"
    end
  end
end
