require 'spec_helper'

describe "dnas/show" do
  before(:each) do
    @dna = assign(:dna, stub_model(Dna,
      :mob => nil,
      :gene => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
