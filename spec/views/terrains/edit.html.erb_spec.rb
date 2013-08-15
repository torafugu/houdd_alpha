require 'spec_helper'

describe "terrains/edit" do
  before(:each) do
    @terrain = assign(:terrain, stub_model(Terrain,
      :symbol => "MyString",
      :name => "MyString",
      :food => 1,
      :production => 1,
      :money => 1,
      :frequency_rate => 1,
      :continuity_mod => 1
    ))
  end

  it "renders the edit terrain form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", terrain_path(@terrain), "post" do
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
