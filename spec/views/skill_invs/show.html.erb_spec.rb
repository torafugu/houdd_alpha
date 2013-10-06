require 'spec_helper'

describe "skill_invs/show" do
  before(:each) do
    @skill_inv = assign(:skill_inv, stub_model(SkillInv,
      :type => "Type",
      :skill => nil,
      :owner_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
