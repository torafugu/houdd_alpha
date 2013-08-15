require 'spec_helper'

describe "researches/edit" do
  before(:each) do
    @research = assign(:research, stub_model(Research,
      :houdd_user => nil,
      :symbol => "MyString",
      :level => 1,
      :allotment => 1,
      :invested_point => 1
    ))
  end

  it "renders the edit research form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", research_path(@research), "post" do
      assert_select "input#research_houdd_user[name=?]", "research[houdd_user]"
      assert_select "input#research_symbol[name=?]", "research[symbol]"
      assert_select "input#research_level[name=?]", "research[level]"
      assert_select "input#research_allotment[name=?]", "research[allotment]"
      assert_select "input#research_invested_point[name=?]", "research[invested_point]"
    end
  end
end
