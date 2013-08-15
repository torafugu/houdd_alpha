require 'spec_helper'

describe "sp_resources/show" do
  before(:each) do
    @sp_resource = assign(:sp_resource, stub_model(SpResource,
      :terrain => nil,
      :symbol => "Symbol",
      :name => "Name",
      :food => 1,
      :production => 2,
      :money => 3,
      :frequency_rate => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Symbol/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
