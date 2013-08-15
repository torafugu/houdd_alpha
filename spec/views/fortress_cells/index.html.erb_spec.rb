require 'spec_helper'

describe "fortress_cells/index" do
  before(:each) do
    assign(:fortress_cells, [
      stub_model(FortressCell,
        :mini_map => nil,
        :symbol => "Symbol",
        :x => 1,
        :y => 2,
        :trap_id => 3,
        :squad_id => 4
      ),
      stub_model(FortressCell,
        :mini_map => nil,
        :symbol => "Symbol",
        :x => 1,
        :y => 2,
        :trap_id => 3,
        :squad_id => 4
      )
    ])
  end

  it "renders a list of fortress_cells" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Symbol".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
