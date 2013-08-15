require 'spec_helper'

describe "constructions/new" do
  before(:each) do
    assign(:construction, stub_model(Construction,
      :terrain => nil,
      :symbol => "MyString",
      :name => "MyString",
      :food => 1,
      :production => 1,
      :money => 1,
      :rq_prod_point => 1,
      :rq_days => 1
    ).as_new_record)
  end

  it "renders new construction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", constructions_path, "post" do
      assert_select "input#construction_terrain[name=?]", "construction[terrain]"
      assert_select "input#construction_symbol[name=?]", "construction[symbol]"
      assert_select "input#construction_name[name=?]", "construction[name]"
      assert_select "input#construction_food[name=?]", "construction[food]"
      assert_select "input#construction_production[name=?]", "construction[production]"
      assert_select "input#construction_money[name=?]", "construction[money]"
      assert_select "input#construction_rq_prod_point[name=?]", "construction[rq_prod_point]"
      assert_select "input#construction_rq_days[name=?]", "construction[rq_days]"
    end
  end
end
