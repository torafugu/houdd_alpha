require 'spec_helper'

describe "specie_job_invs/show" do
  before(:each) do
    @specie_job_inv = assign(:specie_job_inv, stub_model(SpecieJobInv,
      :specie => nil,
      :job => nil,
      :frequency_rate => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
