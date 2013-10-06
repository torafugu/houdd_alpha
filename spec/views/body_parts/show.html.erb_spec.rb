require 'spec_helper'

describe "body_parts/show" do
  before(:each) do
    @body_part = assign(:body_part, stub_model(BodyPart,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
