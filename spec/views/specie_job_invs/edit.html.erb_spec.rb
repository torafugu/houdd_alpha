require 'spec_helper'

describe "specie_job_invs/edit" do
  before(:each) do
    @specie_job_inv = assign(:specie_job_inv, stub_model(SpecieJobInv,
      :specie => nil,
      :job => nil,
      :frequency_rate => 1
    ))
  end

  it "renders the edit specie_job_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", specie_job_inv_path(@specie_job_inv), "post" do
      assert_select "input#specie_job_inv_specie[name=?]", "specie_job_inv[specie]"
      assert_select "input#specie_job_inv_job[name=?]", "specie_job_inv[job]"
      assert_select "input#specie_job_inv_frequency_rate[name=?]", "specie_job_inv[frequency_rate]"
    end
  end
end
