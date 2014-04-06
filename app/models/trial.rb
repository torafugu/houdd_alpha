# This class describes a trial.
class Trial < ActiveRecord::Base
  belongs_to :mini_map
  belongs_to :guard_mission, :class_name => 'Mission', :foreign_key => 'guard_mission_id'
  belongs_to :intruder_mission, :class_name => 'Mission', :foreign_key => 'intruder_mission_id'

  has_many :trial_move_turns
  has_many :trial_fortress_cells
  has_many :trial_squads

  # Maximum distance among squads in fortress.
  MAX_DISTANCE = 9999

  # Return all the guard squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_guard_squads
    active_guard_squads = Array.new
    guard_mission.squads.each do |squad|
      active_guard_squads << squad if squad.entried? and not squad.annihilated? and not squad.retreatd_from_fortress?
    end
    return active_guard_squads
  end

  # Return all the intruder squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_intruder_squads
    active_intruder_squads = Array.new
    intruder_mission.squads.each do |squad|
      active_intruder_squads << squad if squad.entried? and not squad.annihilated? and not squad.retreatd_from_fortress?
    end
    return active_intruder_squads
  end

  # Return all the squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_squads
    return active_guard_squads + active_intruder_squads
  end

  # Return squads which were sorted by dex.
  # @note This method calls Tools.sort_by_dex(array, param)
  # @return [Array].
  def dex_sorted_squads
    return Tools.sort_by_dex(active_squads)
  end

  # Return fortress x size.
  # @return [Integer].
  def fortress_x_size
    return mini_map.size * Params::FORTRESS_SIZE_MULTIPLIER - 1
  end

  # Return fortress y size.
  # @return [Integer].
  def fortress_y_size
    return mini_map.size * Params::FORTRESS_SIZE_MULTIPLIER - 1
  end

  # Return fortress goal point.
  # @return [Object].
  def fortress_goal_point
    trial_fortress_cells.each do |cell|
      return Point.new(cell.x, cell.y) if cell.goal_flg
    end
  end

  # Return exit cells of fortress.
  # @return [Array].
  def fortress_exit_cells
    FortressCell.where("mini_map_id = ? and (x = 0 or y = 0 or x = ? or y = ?) and symbol = ? and squad_id is null", mini_map.id, fortress_x_size, fortress_y_size, :concrete.to_s)
  end

  # Return squads which were sorted by dex.
  # @note Dex is normalized by standard deviation before sorting.
  # @return [Array].
  def nearest_fortress_exit_point(point)
    nearest_fortress_cell = nil
    nearest_distance = MAX_DISTANCE
    fortress_exit_cells.each do |exit_cell|
      distance = Tools.calc_distance(point, exit_cell)
      if distance < nearest_distance
        nearest_distance = distance
        nearest_fortress_exit_cell = exit_cell
      end
    end
    return Point.new(nearest_fortress_cell.x, nearest_fortress_cell.y)
  end

  # Return true if all of intruder or guard squads are retreated or annihilated.
  # @return [Boolean].
  def ended?
    return true if guard_defeated? or intruder_defeated?
    return false
  end

  private

  def guard_defeated?
    guard_mission.squads.each do |squad|
      return false if not squad.annihilated? and not squad.retreatd_from_fortress? and squad.entried?
    end
    return true
  end

  def intruder_defeated?
    intruder_mission.squads.each do |squad|
      return false if not squad.annihilated? and not squad.retreatd_from_fortress? and squad.entried?
    end
    return true
  end
end
