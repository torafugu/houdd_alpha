require 'spec_helper'

describe "mobs/edit" do
  before(:each) do
    @mob = assign(:mob, stub_model(Mob,
      :houdd_user => nil,
      :specie => nil,
      :father_id => 1,
      :mother_id => 1,
      :generation => 1,
      :job => nil,
      :squad => nil,
      :name => "MyString",
      :gender_sym => "MyString",
      :age => 1,
      :hp => 1,
      :sp => 1,
      :str => 1,
      :dex => 1,
      :con => 1,
      :int => 1,
      :wis => 1,
      :cha => 1,
      :phys_def => 1,
      :skill_def => 1,
      :ele_fw => 1,
      :ele_ld => 1,
      :natural_death_flg => false
    ))
  end

  it "renders the edit mob form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mob_path(@mob), "post" do
      assert_select "input#mob_houdd_user[name=?]", "mob[houdd_user]"
      assert_select "input#mob_specie[name=?]", "mob[specie]"
      assert_select "input#mob_father_id[name=?]", "mob[father_id]"
      assert_select "input#mob_mother_id[name=?]", "mob[mother_id]"
      assert_select "input#mob_generation[name=?]", "mob[generation]"
      assert_select "input#mob_job[name=?]", "mob[job]"
      assert_select "input#mob_squad[name=?]", "mob[squad]"
      assert_select "input#mob_name[name=?]", "mob[name]"
      assert_select "input#mob_gender_sym[name=?]", "mob[gender_sym]"
      assert_select "input#mob_age[name=?]", "mob[age]"
      assert_select "input#mob_hp[name=?]", "mob[hp]"
      assert_select "input#mob_sp[name=?]", "mob[sp]"
      assert_select "input#mob_str[name=?]", "mob[str]"
      assert_select "input#mob_dex[name=?]", "mob[dex]"
      assert_select "input#mob_con[name=?]", "mob[con]"
      assert_select "input#mob_int[name=?]", "mob[int]"
      assert_select "input#mob_wis[name=?]", "mob[wis]"
      assert_select "input#mob_cha[name=?]", "mob[cha]"
      assert_select "input#mob_phys_def[name=?]", "mob[phys_def]"
      assert_select "input#mob_skill_def[name=?]", "mob[skill_def]"
      assert_select "input#mob_ele_fw[name=?]", "mob[ele_fw]"
      assert_select "input#mob_ele_ld[name=?]", "mob[ele_ld]"
      assert_select "input#mob_natural_death_flg[name=?]", "mob[natural_death_flg]"
    end
  end
end
