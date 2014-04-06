require 'spec_helper'

describe "item_infos/show" do
  before(:each) do
    @item_info = assign(:item_info, stub_model(ItemInfo,
      :type_symbol => "Type Symbol",
      :element_symbol => "Element Symbol",
      :name => "Name",
      :num_of_tgt => 1,
      :hit_accuracy => 2,
      :range => 3,
      :damage => 4,
      :heal => 5,
      :str_mod => 1.5,
      :dex_mod => 1.5,
      :con_mod => 1.5,
      :int_mod => 1.5,
      :wis_mod => 1.5,
      :cha_mod => 1.5,
      :ele_fw_mod => 1.5,
      :ele_ld_mod => 1.5,
      :phys_def_mod => 1.5,
      :skill_def_mod => 1.5,
      :duration => 6,
      :family => nil,
      :weight_level => 7,
      :max_dp => 8,
      :rq_prod_point => 9,
      :atk_cycle => 10,
      :research_level => 11
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type Symbol/)
    rendered.should match(/Element Symbol/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/6/)
    rendered.should match(//)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/11/)
  end
end
