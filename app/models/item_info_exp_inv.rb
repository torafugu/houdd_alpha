class ItemInfoExpInv < ExpInv
  belongs_to :mob
  belongs_to :item_info, :class_name => 'ItemInfo', :foreign_key => :owner_id
end
