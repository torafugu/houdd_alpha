class JobSkillInv < SkillInv
  belongs_to :skill
  belongs_to :job, :class_name => 'Job', :foreign_key => :owner_id
end
