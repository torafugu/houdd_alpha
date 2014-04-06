# Inventory class of Job and Skill.
class JobSkillInv < ActiveRecord::Base
  belongs_to :skill
  belongs_to :job
end
