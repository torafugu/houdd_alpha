# This class describes a mob for trial.
class TrialMob < ActiveRecord::Base
  belongs_to :trial_squad
  attr_accessible :hp, :job_name, :job_name, :max_hp, :max_sp, :mob_id, :name, :sp
end
