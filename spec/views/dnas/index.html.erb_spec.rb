require 'spec_helper'

describe "dnas/index" do
  before(:each) do
    assign(:dnas, [
      stub_model(Dna,
        :mob => nil,
        :gene => nil
      ),
      stub_model(Dna,
        :mob => nil,
        :gene => nil
      )
    ])
  end

  it "renders a list of dnas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
