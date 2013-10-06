require 'spec_helper'

describe "skill_categories/show" do
  before(:each) do
    @skill_category = assign(:skill_category, stub_model(SkillCategory,
      :type_sym => "Type Sym",
      :element_sym => "Element Sym"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type Sym/)
    rendered.should match(/Element Sym/)
  end
end
