require 'spec_helper'

describe "squads/edit" do
  before(:each) do
    @squad = assign(:squad, stub_model(Squad,
      :houdd_user => nil,
      :mini_map => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit squad form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", squad_path(@squad), "post" do
      assert_select "input#squad_houdd_user[name=?]", "squad[houdd_user]"
      assert_select "input#squad_mini_map[name=?]", "squad[mini_map]"
      assert_select "input#squad_name[name=?]", "squad[name]"
    end
  end
end
