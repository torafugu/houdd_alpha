class SpecieSkillInv < SkillInv
  belongs_to :skill
  belongs_to :specie, :class_name => 'Specie', :foreign_key => :owner_id
end
