require 'spec_helper'

describe "houdd_users/show" do
  before(:each) do
    @houdd_user = assign(:houdd_user, stub_model(HouddUser,
      :name => "Name",
      :admin_flg => false,
      :login_id => "Login",
      :login_pw => "Login Pw",
      :active_flg => false,
      :allot_for_item => 1,
      :allot_for_const => 2,
      :allot_for_research => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/false/)
    rendered.should match(/Login/)
    rendered.should match(/Login Pw/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
