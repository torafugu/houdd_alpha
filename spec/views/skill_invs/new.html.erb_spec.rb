require 'spec_helper'

describe "skill_invs/new" do
  before(:each) do
    assign(:skill_inv, stub_model(SkillInv,
      :type => "",
      :skill => nil,
      :owner_id => 1
    ).as_new_record)
  end

  it "renders new skill_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_invs_path, "post" do
      assert_select "input#skill_inv_type[name=?]", "skill_inv[type]"
      assert_select "input#skill_inv_skill[name=?]", "skill_inv[skill]"
      assert_select "input#skill_inv_owner_id[name=?]", "skill_inv[owner_id]"
    end
  end
end
