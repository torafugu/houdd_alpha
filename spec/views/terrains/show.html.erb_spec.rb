require 'spec_helper'

describe "terrains/show" do
  before(:each) do
    @terrain = assign(:terrain, stub_model(Terrain,
      :symbol => "Symbol",
      :name => "Name",
      :food => 1,
      :production => 2,
      :money => 3,
      :frequency_rate => 4,
      :continuity_mod => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Symbol/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
