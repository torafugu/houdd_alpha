require 'spec_helper'

describe "body_parts/new" do
  before(:each) do
    assign(:body_part, stub_model(BodyPart,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new body_part form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", body_parts_path, "post" do
      assert_select "input#body_part_name[name=?]", "body_part[name]"
    end
  end
end
