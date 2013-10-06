require 'spec_helper'

describe "dnas/new" do
  before(:each) do
    assign(:dna, stub_model(Dna,
      :mob => nil,
      :gene => nil
    ).as_new_record)
  end

  it "renders new dna form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dnas_path, "post" do
      assert_select "input#dna_mob[name=?]", "dna[mob]"
      assert_select "input#dna_gene[name=?]", "dna[gene]"
    end
  end
end
