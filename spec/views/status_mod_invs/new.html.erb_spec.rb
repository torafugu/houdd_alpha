require 'spec_helper'

describe "status_mod_invs/new" do
  before(:each) do
    assign(:status_mod_inv, stub_model(StatusModInv,
      :type => "",
      :status_mod => nil,
      :owner_id => 1,
      :num_of_tgt => 1,
      :duration => 1
    ).as_new_record)
  end

  it "renders new status_mod_inv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", status_mod_invs_path, "post" do
      assert_select "input#status_mod_inv_type[name=?]", "status_mod_inv[type]"
      assert_select "input#status_mod_inv_status_mod[name=?]", "status_mod_inv[status_mod]"
      assert_select "input#status_mod_inv_owner_id[name=?]", "status_mod_inv[owner_id]"
      assert_select "input#status_mod_inv_num_of_tgt[name=?]", "status_mod_inv[num_of_tgt]"
      assert_select "input#status_mod_inv_duration[name=?]", "status_mod_inv[duration]"
    end
  end
end
