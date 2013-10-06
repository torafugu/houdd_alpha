class FamilySkillInv < SkillInv
  belongs_to :skill
  belongs_to :family, :class_name => 'Family', :foreign_key => :owner_id
end
