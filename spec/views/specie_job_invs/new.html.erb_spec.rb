require 'spec_helper'

describe "specie_job_invs/new" do
  before(:each) do
    assign(:specie_job_inv, stub_model(SpecieJobInv,
      :specie => nil,
      :job => nil,
      :frequency_rate => 1
    ).as_new_record)
  end

  it "renders new specie_job_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", specie_job_invs_path, "post" do
      assert_select "input#specie_job_inv_specie[name=?]", "specie_job_inv[specie]"
      assert_select "input#specie_job_inv_job[name=?]", "specie_job_inv[job]"
      assert_select "input#specie_job_inv_frequency_rate[name=?]", "specie_job_inv[frequency_rate]"
    end
  end
end
