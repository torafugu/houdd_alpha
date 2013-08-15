require 'spec_helper'

describe "sp_resources/edit" do
  before(:each) do
    @sp_resource = assign(:sp_resource, stub_model(SpResource,
      :terrain => nil,
      :symbol => "MyString",
      :name => "MyString",
      :food => 1,
      :production => 1,
      :money => 1,
      :frequency_rate => 1
    ))
  end

  it "renders the edit sp_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sp_resource_path(@sp_resource), "post" do
      assert_select "input#sp_resource_terrain[name=?]", "sp_resource[terrain]"
      assert_select "input#sp_resource_symbol[name=?]", "sp_resource[symbol]"
      assert_select "input#sp_resource_name[name=?]", "sp_resource[name]"
      assert_select "input#sp_resource_food[name=?]", "sp_resource[food]"
      assert_select "input#sp_resource_production[name=?]", "sp_resource[production]"
      assert_select "input#sp_resource_money[name=?]", "sp_resource[money]"
      assert_select "input#sp_resource_frequency_rate[name=?]", "sp_resource[frequency_rate]"
    end
  end
end
