require 'spec_helper'

describe "researches/show" do
  before(:each) do
    @research = assign(:research, stub_model(Research,
      :houdd_user => nil,
      :symbol => "Symbol",
      :level => 1,
      :allotment => 2,
      :invested_point => 3
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
  end
end
