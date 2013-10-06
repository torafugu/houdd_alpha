require 'spec_helper'

describe "skill_invs/edit" do
  before(:each) do
    @skill_inv = assign(:skill_inv, stub_model(SkillInv,
      :type => "",
      :skill => nil,
      :owner_id => 1
    ))
  end

  it "renders the edit skill_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_inv_path(@skill_inv), "post" do
      assert_select "input#skill_inv_type[name=?]", "skill_inv[type]"
      assert_select "input#skill_inv_skill[name=?]", "skill_inv[skill]"
      assert_select "input#skill_inv_owner_id[name=?]", "skill_inv[owner_id]"
    end
  end
end
