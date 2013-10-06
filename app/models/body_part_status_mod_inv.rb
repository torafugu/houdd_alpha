class BodyPartStatusModInv < StatusModInv
  belongs_to :status_mod
  belongs_to :body_part_inv, :class_name => 'BodyPartInv', :foreign_key => :owner_id
end
