# This class is clearer of Trial.
class TrialDeleter
  def self.execute(trial_id)
    TrialMoveTurn.destroy_all(["trial_id = ?", trial_id])
    TrialFortressCell.destroy_all(["trial_id = ?", trial_id])
    TrialSquad.destroy_all(["trial_id = ?", trial_id])
  end
end