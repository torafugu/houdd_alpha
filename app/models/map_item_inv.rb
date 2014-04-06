# Inventory class of Map and Item.
class MapItemInv < ActiveRecord::Base
  belongs_to :mini_map
  belongs_to :item
end
