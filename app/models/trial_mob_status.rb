class TrialMobStatus < ActiveRecord::Base
  belongs_to :trial_move_turn
  belongs_to :trial_mob
end
