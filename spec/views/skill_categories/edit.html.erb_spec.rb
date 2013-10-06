require 'spec_helper'

describe "skill_categories/edit" do
  before(:each) do
    @skill_category = assign(:skill_category, stub_model(SkillCategory,
      :type_sym => "MyString",
      :element_sym => "MyString"
    ))
  end

  it "renders the edit skill_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_category_path(@skill_category), "post" do
      assert_select "input#skill_category_type_sym[name=?]", "skill_category[type_sym]"
      assert_select "input#skill_category_element_sym[name=?]", "skill_category[element_sym]"
    end
  end
end
