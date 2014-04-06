# This class describes a squad trail of trial.
class TrialSquadTrail < ActiveRecord::Base
  belongs_to :trial_move_turn
  belongs_to :trial_squad
end
