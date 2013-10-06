require 'spec_helper'

describe "skills/edit" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :skill_category => nil,
      :name => "MyString",
      :sp_cost => 1,
      :research_level => 1
    ))
  end

  it "renders the edit skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_path(@skill), "post" do
      assert_select "input#skill_skill_category[name=?]", "skill[skill_category]"
      assert_select "input#skill_name[name=?]", "skill[name]"
      assert_select "input#skill_sp_cost[name=?]", "skill[sp_cost]"
      assert_select "input#skill_research_level[name=?]", "skill[research_level]"
    end
  end
end
