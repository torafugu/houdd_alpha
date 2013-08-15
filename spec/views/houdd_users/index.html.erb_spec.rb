require 'spec_helper'

describe "houdd_users/index" do
  before(:each) do
    assign(:houdd_users, [
      stub_model(HouddUser,
        :name => "Name",
        :admin_flg => false,
        :login_id => "Login",
        :login_pw => "Login Pw",
        :active_flg => false,
        :allot_for_item => 1,
        :allot_for_const => 2,
        :allot_for_research => 3
      ),
      stub_model(HouddUser,
        :name => "Name",
        :admin_flg => false,
        :login_id => "Login",
        :login_pw => "Login Pw",
        :active_flg => false,
        :allot_for_item => 1,
        :allot_for_const => 2,
        :allot_for_research => 3
      )
    ])
  end

  it "renders a list of houdd_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Login".to_s, :count => 2
    assert_select "tr>td", :text => "Login Pw".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
