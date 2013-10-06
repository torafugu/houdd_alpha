require 'spec_helper'

describe "skill_invs/index" do
  before(:each) do
    assign(:skill_invs, [
      stub_model(SkillInv,
        :type => "Type",
        :skill => nil,
        :owner_id => 1
      ),
      stub_model(SkillInv,
        :type => "Type",
        :skill => nil,
        :owner_id => 1
      )
    ])
  end

  it "renders a list of skill_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
