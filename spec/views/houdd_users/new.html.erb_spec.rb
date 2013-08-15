require 'spec_helper'

describe "houdd_users/new" do
  before(:each) do
    assign(:houdd_user, stub_model(HouddUser,
      :name => "MyString",
      :admin_flg => false,
      :login_id => "MyString",
      :login_pw => "MyString",
      :active_flg => false,
      :allot_for_item => 1,
      :allot_for_const => 1,
      :allot_for_research => 1
    ).as_new_record)
  end

  it "renders new houdd_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", houdd_users_path, "post" do
      assert_select "input#houdd_user_name[name=?]", "houdd_user[name]"
      assert_select "input#houdd_user_admin_flg[name=?]", "houdd_user[admin_flg]"
      assert_select "input#houdd_user_login_id[name=?]", "houdd_user[login_id]"
      assert_select "input#houdd_user_login_pw[name=?]", "houdd_user[login_pw]"
      assert_select "input#houdd_user_active_flg[name=?]", "houdd_user[active_flg]"
      assert_select "input#houdd_user_allot_for_item[name=?]", "houdd_user[allot_for_item]"
      assert_select "input#houdd_user_allot_for_const[name=?]", "houdd_user[allot_for_const]"
      assert_select "input#houdd_user_allot_for_research[name=?]", "houdd_user[allot_for_research]"
    end
  end
end
