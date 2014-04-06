# This class describes a squad for trial.
class TrialSquad < ActiveRecord::Base
  belongs_to :trial
  has_many :trial_mobs, :dependent => :delete_all
end
