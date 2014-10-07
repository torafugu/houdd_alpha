# This class describes a squad trail of trial.
class TrialSquadTrail < ActiveRecord::Base
  belongs_to :trial_move_turn
  belongs_to :trial_squad
  attr_accessor :intruder_flg, :annihilated_flg, :trail_type

  # Direction character of North.
  NORTH = 'N'

  # Direction character of South.
  SOUTH = 'S'

  # Direction character of West.
  WEST = 'W'

  # Direction character of East.
  EAST = 'E'

  # Return character of direction.(N, S, E, W)
  # @return [String]
  def direction
    if to_x - from_x > 0
      return EAST
    elsif to_x - from_x < 0
      return WEST
    end

    if to_y - from_y > 0
      return SOUTH
    elsif to_y - from_y < 0
      return NORTH
    end

    distance_to_center_x = trial_move_turn.trial.fortress_center_point.x - from_x
    distance_to_center_y = trial_move_turn.trial.fortress_center_point.y - from_y
    if distance_to_center_y.abs < distance_to_center_x.abs
      if 0 < distance_to_center_x
        return EAST if trial_squad.intruder_flg
        return WEST
      else
        return WEST if trial_squad.intruder_flg
        return EAST
      end
    else
      if 0 < distance_to_center_y
        return SOUTH if trial_squad.intruder_flg
        return NORTH
      else
        return NORTH if trial_squad.intruder_flg
        return SOUTH
      end
    end
  end
end
