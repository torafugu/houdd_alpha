class ItemSpResourceInv < ActiveRecord::Base
  belongs_to :item_info
  belongs_to :sp_resource
end
