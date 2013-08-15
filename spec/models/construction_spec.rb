require 'spec_helper'

describe Construction do
  it 'img_file returns proper file name.' do
    construction = FactoryGirl.create(:construction)
    symbol = construction.symbol
    expect(construction.img_file).to match /\w+_#{symbol}/
  end
end
