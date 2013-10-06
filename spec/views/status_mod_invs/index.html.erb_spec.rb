require 'spec_helper'

describe "status_mod_invs/index" do
  before(:each) do
    assign(:status_mod_invs, [
      stub_model(StatusModInv,
        :type => "Type",
        :status_mod => nil,
        :owner_id => 1,
        :num_of_tgt => 2,
        :duration => 3
      ),
      stub_model(StatusModInv,
        :type => "Type",
        :status_mod => nil,
        :owner_id => 1,
        :num_of_tgt => 2,
        :duration => 3
      )
    ])
  end

  it "renders a list of status_mod_invs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
