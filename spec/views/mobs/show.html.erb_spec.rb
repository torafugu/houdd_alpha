require 'spec_helper'

describe "mobs/show" do
  before(:each) do
    @mob = assign(:mob, stub_model(Mob,
      :houdd_user => nil,
      :specie => nil,
      :father_id => 1,
      :mother_id => 2,
      :generation => 3,
      :job => nil,
      :squad => nil,
      :name => "Name",
      :gender_sym => "Gender Sym",
      :age => 4,
      :hp => 5,
      :sp => 6,
      :str => 7,
      :dex => 8,
      :con => 9,
      :int => 10,
      :wis => 11,
      :cha => 12,
      :phys_def => 13,
      :skill_def => 14,
      :ele_fw => 15,
      :ele_ld => 16,
      :natural_death_flg => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/Gender Sym/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/11/)
    rendered.should match(/12/)
    rendered.should match(/13/)
    rendered.should match(/14/)
    rendered.should match(/15/)
    rendered.should match(/16/)
    rendered.should match(/false/)
  end
end
