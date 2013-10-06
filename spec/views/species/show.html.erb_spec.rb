require 'spec_helper'

describe "species/show" do
  before(:each) do
    @specie = assign(:specie, stub_model(Specie,
      :family => nil,
      :name => "Name",
      :longevity => 1,
      :prolificacy => 1.5,
      :growth_rate => 1.5,
      :food_cost => 2,
      :str => 3,
      :dex => 4,
      :con => 5,
      :int => 6,
      :wis => 7,
      :cha => 8,
      :mutation_rate => 1.5,
      :phys_def => 9,
      :skill_def => 10,
      :ele_fw => 11,
      :ele_ld => 12
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/1.5/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/11/)
    rendered.should match(/12/)
  end
end
