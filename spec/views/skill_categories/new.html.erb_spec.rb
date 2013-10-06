require 'spec_helper'

describe "skill_categories/new" do
  before(:each) do
    assign(:skill_category, stub_model(SkillCategory,
      :type_sym => "MyString",
      :element_sym => "MyString"
    ).as_new_record)
  end

  it "renders new skill_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_categories_path, "post" do
      assert_select "input#skill_category_type_sym[name=?]", "skill_category[type_sym]"
      assert_select "input#skill_category_element_sym[name=?]", "skill_category[element_sym]"
    end
  end
end
