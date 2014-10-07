# This class describes a status of mob for trial.
class TrialMobStatus < ActiveRecord::Base
  belongs_to :trial_battle_turn
  belongs_to :trial_mob
  attr_accessible :end_hp, :end_sp, :end_status, :start_hp, :start_sp, :start_status, :vpos

  # Return true if this mob belongs to attacker squad.
  # @return [Boolean].
  def attacker?
    if trial_battle_turn.trial_battle_set.attacker_squad_id == trial_mob.trial_squad.id
      true
    else
      false
    end
  end

  # Return true if this mob is dead.
  # @return [Boolean].
  def dead?
    return true if end_hp == 0
    false
  end

  # Return true if this mob has been just dead. (i.e. dead in same battle turn.)
  # @return [Boolean].
  def just_dead?
    return true if end_hp == 0 and start_hp > 0
    false
  end
end
