require 'spec_helper'

describe "fortress_cells/edit" do
  before(:each) do
    @fortress_cell = assign(:fortress_cell, stub_model(FortressCell,
      :mini_map => nil,
      :symbol => "MyString",
      :x => 1,
      :y => 1,
      :trap_id => 1,
      :squad_id => 1
    ))
  end

  it "renders the edit fortress_cell form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fortress_cell_path(@fortress_cell), "post" do
      assert_select "input#fortress_cell_mini_map[name=?]", "fortress_cell[mini_map]"
      assert_select "input#fortress_cell_symbol[name=?]", "fortress_cell[symbol]"
      assert_select "input#fortress_cell_x[name=?]", "fortress_cell[x]"
      assert_select "input#fortress_cell_y[name=?]", "fortress_cell[y]"
      assert_select "input#fortress_cell_trap_id[name=?]", "fortress_cell[trap_id]"
      assert_select "input#fortress_cell_squad_id[name=?]", "fortress_cell[squad_id]"
    end
  end
end
