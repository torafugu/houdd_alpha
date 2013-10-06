require 'spec_helper'

describe "specie_job_invs/index" do
  before(:each) do
    assign(:specie_job_invs, [
      stub_model(SpecieJobInv,
        :specie => nil,
        :job => nil,
        :frequency_rate => 1
      ),
      stub_model(SpecieJobInv,
        :specie => nil,
        :job => nil,
        :frequency_rate => 1
      )
    ])
  end

  it "renders a list of specie_job_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
