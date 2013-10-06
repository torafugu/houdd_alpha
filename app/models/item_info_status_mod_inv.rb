class ItemInfoStatusModInv < StatusModInv
  belongs_to :status_mod
  belongs_to :item_info, :class_name => 'ItemInfo', :foreign_key => :owner_id
end
