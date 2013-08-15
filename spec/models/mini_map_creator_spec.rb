require 'spec_helper'

describe MiniMapCreator do
  it 'The number of created mini_map_cells is correct.' do
    mini_map = FactoryGirl.create(:mini_map)
    MiniMapCreator.random_cell(mini_map.id)
    expect(mini_map.mini_map_cells.size).to eq(mini_map.size * mini_map.size)
  end
end
