require 'spec_helper'

describe "skill_categories/index" do
  before(:each) do
    assign(:skill_categories, [
      stub_model(SkillCategory,
        :type_sym => "Type Sym",
        :element_sym => "Element Sym"
      ),
      stub_model(SkillCategory,
        :type_sym => "Type Sym",
        :element_sym => "Element Sym"
      )
    ])
  end

  it "renders a list of skill_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type Sym".to_s, :count => 2
    assert_select "tr>td", :text => "Element Sym".to_s, :count => 2
  end
end
