require 'spec_helper'

describe "missions/show" do
  before(:each) do
    @mission = assign(:mission, stub_model(Mission,
      :houdd_user => nil,
      :mini_map => nil,
      :category_symbol => "Category Symbol",
      :mission_strategy => nil,
      :status_symbol => "Status Symbol",
      :start_houdd_time => "9.99",
      :end_houdd_time => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Category Symbol/)
    rendered.should match(//)
    rendered.should match(/Status Symbol/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
