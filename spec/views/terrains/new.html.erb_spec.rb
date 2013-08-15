require 'spec_helper'

describe "terrains/new" do
  before(:each) do
    assign(:terrain, stub_model(Terrain,
      :symbol => "MyString",
      :name => "MyString",
      :food => 1,
      :production => 1,
      :money => 1,
      :frequency_rate => 1,
      :continuity_mod => 1
    ).as_new_record)
  end

  it "renders new terrain form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", terrains_path, "post" do
      assert_select "input#terrain_symbol[name=?]", "terrain[symbol]"
      assert_select "input#terrain_name[name=?]", "terrain[name]"
      assert_select "input#terrain_food[name=?]", "terrain[food]"
      assert_select "input#terrain_production[name=?]", "terrain[production]"
      assert_select "input#terrain_money[name=?]", "terrain[money]"
      assert_select "input#terrain_frequency_rate[name=?]", "terrain[frequency_rate]"
      assert_select "input#terrain_continuity_mod[name=?]", "terrain[continuity_mod]"
    end
  end
end
