require 'spec_helper'

describe "families/edit" do
  before(:each) do
    @family = assign(:family, stub_model(Family,
      :name => "MyString",
      :asexual_flg => false
    ))
  end

  it "renders the edit family form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", family_path(@family), "post" do
      assert_select "input#family_name[name=?]", "family[name]"
      assert_select "input#family_asexual_flg[name=?]", "family[asexual_flg]"
    end
  end
end
