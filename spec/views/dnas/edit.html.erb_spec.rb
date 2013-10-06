require 'spec_helper'

describe "dnas/edit" do
  before(:each) do
    @dna = assign(:dna, stub_model(Dna,
      :mob => nil,
      :gene => nil
    ))
  end

  it "renders the edit dna form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dna_path(@dna), "post" do
      assert_select "input#dna_mob[name=?]", "dna[mob]"
      assert_select "input#dna_gene[name=?]", "dna[gene]"
    end
  end
end
