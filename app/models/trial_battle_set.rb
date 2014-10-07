# This class describes a battle set of trial.
class TrialBattleSet < ActiveRecord::Base
  belongs_to :trial_move_turn
  belongs_to :attacker_squad, :class_name => 'TrialSquad', :foreign_key => 'attacker_squad_id'
  belongs_to :defender_squad, :class_name => 'TrialSquad', :foreign_key => 'defender_squad_id'
  has_many :trial_battle_turns, :dependent => :delete_all
  attr_accessible :distance
end
