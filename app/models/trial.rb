# This class describes a trial.
class Trial < ActiveRecord::Base
  belongs_to :mini_map
  belongs_to :guard_mission, :class_name => 'Mission', :foreign_key => 'guard_mission_id'
  belongs_to :intruder_mission, :class_name => 'Mission', :foreign_key => 'intruder_mission_id'

  has_many :trial_move_turns, :dependent => :delete_all
  has_many :trial_fortress_cells, :dependent => :delete_all
  has_many :trial_squads, :dependent => :delete_all

  attr_accessor :goal_was_occupied

  # Maximum distance among squads in fortress.
  MAX_DISTANCE = 9999

  # Return all the guard squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_guard_squads
    active_guard_squads = Array.new
    guard_mission.squads.each do |squad|
      active_guard_squads << squad if squad.entried and not squad.annihilated? and not squad.retreated_from_fortress
    end
    return active_guard_squads
  end

  # Return all the intruder squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_intruder_squads
    active_intruder_squads = Array.new
    intruder_mission.squads.each do |squad|
      active_intruder_squads << squad if squad.entried and not squad.annihilated? and not squad.retreated_from_fortress
    end
    return active_intruder_squads
  end

  # Return all the squads which is not yet annihilated or escaped.
  # @return [Array].
  def active_squads
    return active_guard_squads + active_intruder_squads
  end

  # Return all the guard squads from TrialSquad.
  # @note Why retrieving from TrialSquad is information at the timing of trial was happen is needed.
  # @return [Array].
  def trial_guard_squads
    guard_squads = Array.new
    trial_squads.each do |trial_squad|
      guard_squads << trial_squad unless trial_squad.intruder_flg
    end
    guard_squads
  end

  # Return all the guard squads from TrialSquad.
  # @note Why retrieving from TrialSquad is information at the timing of trial was happen is needed.
  # @return [Array].
  def trial_intruder_squads
    intruder_squads = Array.new
    trial_squads.each do |trial_squad|
      intruder_squads << trial_squad if trial_squad.intruder_flg
    end
    intruder_squads
  end

  # Set max hp and max sp to hp and sp of trial mobs.
  def initialize_trial_squads_status
    trial_squads.each do |trial_squad|
      trial_squad.trial_mobs.each do |trial_mob|
        trial_mob.hp = trial_mob.max_hp
        trial_mob.sp = trial_mob.max_sp
        trial_mob.save
      end
    end
  end

  # Return all the squads status from the latest TrialBattleTurn.
  # @param [Integer] trial_move_turn_id
  def update_trial_squads_status(trial_move_turn_id)
    p trial_move_turn_id
    trial_move_turns.reverse.each do |turn|
      # p turn.id
      # Seeking the latest trial_battle_set.
      next if trial_move_turn_id < turn.id
      next if turn.trial_battle_sets.blank?
      # p turn

      # Set hp and sp.
      turn.trial_battle_sets.each do |battle_set|
        p battle_set
        trial_squads.each do |trial_squad|
          next if trial_squad.id != battle_set.attacker_squad_id and trial_squad.id != battle_set.defender_squad_id
          trial_squad.trial_mobs.each do |trial_mob|
            status = TrialMobStatus.includes(:trial_battle_turn).where("trial_battle_turns.trial_battle_set_id = ? and trial_mob_id = ?", battle_set.id, trial_mob.id).last
            trial_mob.hp = status.end_hp
            trial_mob.sp = status.end_sp
            trial_mob.save
          end
        end

      end
      break
    end
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
    return FortressCell.where("mini_map_id=?", mini_map.id).maximum('x')
  end

  # Return fortress y size.
  # @return [Integer].
  def fortress_y_size
    return FortressCell.where("mini_map_id=?", mini_map.id).maximum('y')
  end

  # Return center point of fortress.
  # @return [Integer].
  def fortress_center_point
    return Point.new((fortress_x_size / 2).truncate, (fortress_y_size / 2).truncate)
  end

  # Return random inside cell of fortress.
  # @return [Integer].
  def fortress_random_point
    FortressCell.where("mini_map_id=? and symbol=?", mini_map.id, :concrete.to_s).sample
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
    nearest_fortress_exit_cell = nil
    nearest_distance = MAX_DISTANCE
    fortress_exit_cells.each do |exit_cell|
      distance = Tools.calc_distance(point, exit_cell)
      if distance < nearest_distance
        nearest_distance = distance
        nearest_fortress_exit_cell = exit_cell
      end
    end
    return Point.new(nearest_fortress_exit_cell.x, nearest_fortress_exit_cell.y)
  end

  # Return trap which is deployed in this cell.
  # @return [Object].
  def fortress_cell_trap(point)
    cell = FortressCell.where("mini_map_id=? and x=? and y=?", mini_map.id, point.x, point.y)
    if cell.blank?
      return nil
    else
      cell.first.trap
    end
  end

  # Return true if guard squad is existing on goal cell.
  # @return [Boolean].
  def goal_cell_guarded?
    guard_mission.squads.each do |squad|
      return true if squad.current_point.equal?(fortress_goal_point)
    end
    return false
  end

  # Return true if all of guard squads are retreated or annihilated.
  # @return [Boolean].
  def guard_defeated?
    return true if @goal_was_occupied
    guard_mission.squads.each do |squad|
      return false if not squad.annihilated? and not squad.retreated_from_fortress and squad.entried
    end
    return true
  end

  # Return true if all of intruder squads are retreated or annihilated.
  # @return [Boolean].
  def intruder_defeated?
    intruder_mission.squads.each do |squad|
      return false if not squad.annihilated? and not squad.retreated_from_fortress and squad.entried
    end
    return true
  end
end
