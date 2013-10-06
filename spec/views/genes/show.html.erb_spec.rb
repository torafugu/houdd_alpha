require 'spec_helper'

describe "genes/show" do
  before(:each) do
    @gene = assign(:gene, stub_model(Gene,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/false/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end
