require 'spec_helper'

describe "status_mod_invs/show" do
  before(:each) do
    @status_mod_inv = assign(:status_mod_inv, stub_model(StatusModInv,
      :type => "Type",
      :status_mod => nil,
      :owner_id => 1,
      :num_of_tgt => 2,
      :duration => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
