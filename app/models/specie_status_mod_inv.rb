class SpecieStatusModInv < StatusModInv
  belongs_to :status_mod
  belongs_to :specie, :class_name => 'Specie', :foreign_key => :owner_id
end
