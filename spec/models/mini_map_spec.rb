require 'spec_helper'

describe MiniMap do
  it 'The mini_map_roads related to mini_map was created.' do
    mini_map_hq = FactoryGirl.create(:mini_map_hq)
    expect {
      MiniMap.find(mini_map_hq.id).mini_map_roads.size
      mini_map_not_hq = FactoryGirl.create(:mini_map_not_hq)
    }.to change{MiniMap.find(mini_map_hq.id).mini_map_roads.size}.by(1)
  end
end
