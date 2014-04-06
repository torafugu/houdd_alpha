require 'spec_helper'

describe "families/new" do
  before(:each) do
    assign(:family, stub_model(Family,
      :name => "MyString",
      :asexual_flg => false,
      :skill => nil
    ).as_new_record)
  end

  it "renders new family form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", families_path, "post" do
      assert_select "input#family_name[name=?]", "family[name]"
      assert_select "input#family_asexual_flg[name=?]", "family[asexual_flg]"
      assert_select "input#family_skill[name=?]", "family[skill]"
    end
  end
end
