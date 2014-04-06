class SkillExpInv < ExpInv
  belongs_to :mob
  belongs_to :skill, :class_name => 'Skill', :foreign_key => :owner_id
end
