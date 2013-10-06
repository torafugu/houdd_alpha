require 'spec_helper'

describe "genes/new" do
  before(:each) do
    assign(:gene, stub_model(Gene,
      :specie => nil,
      :dominance_flg => false,
      :prolificacy_mod => 1.5,
      :longevity_mod => 1.5,
      :growth_mod => 1.5,
      :food_cost_mod => 1.5,
      :str_mod => 1.5,
      :dex_mod => 1.5,
      :con_mod => 1.5,
      :int_mod => 1.5,
      :wis_mod => 1.5,
      :cha_mod => 1.5,
      :ele_fw_mod => 1.5,
      :ele_ld_mod => 1.5,
      :phys_def_mod => 1.5,
      :skill_def_mod => 1.5
    ).as_new_record)
  end

  it "renders new gene form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", genes_path, "post" do
      assert_select "input#gene_specie[name=?]", "gene[specie]"
      assert_select "input#gene_dominance_flg[name=?]", "gene[dominance_flg]"
      assert_select "input#gene_prolificacy_mod[name=?]", "gene[prolificacy_mod]"
      assert_select "input#gene_longevity_mod[name=?]", "gene[longevity_mod]"
      assert_select "input#gene_growth_mod[name=?]", "gene[growth_mod]"
      assert_select "input#gene_food_cost_mod[name=?]", "gene[food_cost_mod]"
      assert_select "input#gene_str_mod[name=?]", "gene[str_mod]"
      assert_select "input#gene_dex_mod[name=?]", "gene[dex_mod]"
      assert_select "input#gene_con_mod[name=?]", "gene[con_mod]"
      assert_select "input#gene_int_mod[name=?]", "gene[int_mod]"
      assert_select "input#gene_wis_mod[name=?]", "gene[wis_mod]"
      assert_select "input#gene_cha_mod[name=?]", "gene[cha_mod]"
      assert_select "input#gene_ele_fw_mod[name=?]", "gene[ele_fw_mod]"
      assert_select "input#gene_ele_ld_mod[name=?]", "gene[ele_ld_mod]"
      assert_select "input#gene_phys_def_mod[name=?]", "gene[phys_def_mod]"
      assert_select "input#gene_skill_def_mod[name=?]", "gene[skill_def_mod]"
    end
  end
end
