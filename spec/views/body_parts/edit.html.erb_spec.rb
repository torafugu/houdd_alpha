require 'spec_helper'

describe "body_parts/edit" do
  before(:each) do
    @body_part = assign(:body_part, stub_model(BodyPart,
      :name => "MyString"
    ))
  end

  it "renders the edit body_part form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", body_part_path(@body_part), "post" do
      assert_select "input#body_part_name[name=?]", "body_part[name]"
    end
  end
end
