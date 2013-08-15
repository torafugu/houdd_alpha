require 'spec_helper'

describe HouddUser do
  it 'The researches related to user were created.' do
    houdd_user = FactoryGirl.create(:houdd_user)
    expect(houdd_user).to have(Params::RESEARCH_SYMBOLS.size).researches
  end
end
