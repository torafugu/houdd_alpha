require 'spec_helper'

describe "species/edit" do
  before(:each) do
    @specie = assign(:specie, stub_model(Specie,
      :family => nil,
      :name => "MyString",
      :longevity => 1,
      :prolificacy => 1.5,
      :growth_rate => 1.5,
      :food_cost => 1,
      :str => 1,
      :dex => 1,
      :con => 1,
      :int => 1,
      :wis => 1,
      :cha => 1,
      :mutation_rate => 1.5,
      :phys_def => 1,
      :skill_def => 1,
      :ele_fw => 1,
      :ele_ld => 1,
      :skill => nil
    ))
  end

  it "renders the edit specie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", specie_path(@specie), "post" do
      assert_select "input#specie_family[name=?]", "specie[family]"
      assert_select "input#specie_name[name=?]", "specie[name]"
      assert_select "input#specie_longevity[name=?]", "specie[longevity]"
      assert_select "input#specie_prolificacy[name=?]", "specie[prolificacy]"
      assert_select "input#specie_growth_rate[name=?]", "specie[growth_rate]"
      assert_select "input#specie_food_cost[name=?]", "specie[food_cost]"
      assert_select "input#specie_str[name=?]", "specie[str]"
      assert_select "input#specie_dex[name=?]", "specie[dex]"
      assert_select "input#specie_con[name=?]", "specie[con]"
      assert_select "input#specie_int[name=?]", "specie[int]"
      assert_select "input#specie_wis[name=?]", "specie[wis]"
      assert_select "input#specie_cha[name=?]", "specie[cha]"
      assert_select "input#specie_mutation_rate[name=?]", "specie[mutation_rate]"
      assert_select "input#specie_phys_def[name=?]", "specie[phys_def]"
      assert_select "input#specie_skill_def[name=?]", "specie[skill_def]"
      assert_select "input#specie_ele_fw[name=?]", "specie[ele_fw]"
      assert_select "input#specie_ele_ld[name=?]", "specie[ele_ld]"
      assert_select "input#specie_skill[name=?]", "specie[skill]"
    end
  end
end
