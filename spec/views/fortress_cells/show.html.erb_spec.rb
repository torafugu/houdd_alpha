require 'spec_helper'

describe "fortress_cells/show" do
  before(:each) do
    @fortress_cell = assign(:fortress_cell, stub_model(FortressCell,
      :mini_map => nil,
      :symbol => "Symbol",
      :x => 1,
      :y => 2,
      :trap_id => 3,
      :squad_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Symbol/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
