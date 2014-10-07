# This class describes a move turn of trial.
class TrialMoveTurn < ActiveRecord::Base
  belongs_to :trial
  has_many :trial_squad_trails, :dependent => :delete_all
  has_many :trial_battle_sets, :dependent => :delete_all
end
