require 'spec_helper'

describe "mini_maps/new" do
  before(:each) do
    assign(:mini_map, stub_model(MiniMap,
      :houdd_user => nil,
      :name => "MyString",
      :size => 1,
      :hq_flg => false,
      :type_symbol => "MyString",
      :find_root_flg => false
    ).as_new_record)
  end

  it "renders new mini_map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mini_maps_path, "post" do
      assert_select "input#mini_map_houdd_user[name=?]", "mini_map[houdd_user]"
      assert_select "input#mini_map_name[name=?]", "mini_map[name]"
      assert_select "input#mini_map_size[name=?]", "mini_map[size]"
      assert_select "input#mini_map_hq_flg[name=?]", "mini_map[hq_flg]"
      assert_select "input#mini_map_type_symbol[name=?]", "mini_map[type_symbol]"
      assert_select "input#mini_map_find_root_flg[name=?]", "mini_map[find_root_flg]"
    end
  end
end
