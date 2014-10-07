# This class is clearer of Trial.
class TrialDeleter
  def self.execute(trial_id)
    # TrialMoveTurn.destroy_all(["trial_id = ?", trial_id])
    TrialFortressCell.destroy_all(["trial_id = ?", trial_id])
    TrialSquad.destroy_all(["trial_id = ?", trial_id])
    deleting_trial = Trial.find(trial_id)
    deleting_trial.trial_move_turns.each do |trial_move_turn|
      trial_move_turn.trial_battle_sets.each do |trial_battle_set|
        trial_battle_set.trial_battle_turns.each do |trial_battle_turn|
          trial_battle_turn.trial_mob_statuses.each do |trial_mob_status|
            trial_mob_status.destroy
          end
          trial_battle_turn.destroy
        end
        trial_battle_set.destroy
      end
      trial_move_turn.destroy
    end

    (deleting_trial.guard_mission.squads + deleting_trial.intruder_mission.squads).each do |squad|
      squad.mobs.each do |mob|
        mob.hp = mob.max_hp
        mob.sp = mob.max_sp
        mob.save
      end
    end
  end
end