require 'spec_helper'

describe "mobs/index" do
  before(:each) do
    assign(:mobs, [
      stub_model(Mob,
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
      ),
      stub_model(Mob,
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
      )
    ])
  end

  it "renders a list of mobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gender Sym".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
    assert_select "tr>td", :text => 13.to_s, :count => 2
    assert_select "tr>td", :text => 14.to_s, :count => 2
    assert_select "tr>td", :text => 15.to_s, :count => 2
    assert_select "tr>td", :text => 16.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
