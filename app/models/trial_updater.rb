# This class is updater of Trial.
class TrialUpdater

  FLAG_CELL_OFFSET_SIZE_RATE = 0.2

  # execute trial updation.
  def self.execute
    Trial.find_all_by_occured_at(nil).each do |trial|
      prepare(trial)
      #squad_setup(trial)
      #until trial.def_defeated? and trial.atk_defeated?
      5.times do |turn_num|
        squad_setup(trial)
        #break if trial.active_squads.blank?
        p "-- proceed_turn " + (turn_num + 1).to_s + " --"
        proceed_turn(trial)
      end
    end
  end

  private

  def self.prepare(trial)

    # 1. Copy cells from FortressCell.
    trial.mini_map.fortress_cells.each do |cell|
      trial_fortress_cell = TrialFortressCell.new
      trial_fortress_cell.trial_id = trial.id
      trial_fortress_cell.symbol = cell.symbol
      trial_fortress_cell.x = cell.x
      trial_fortress_cell.y = cell.y
      trial_fortress_cell.save
      trial.trial_fortress_cells << trial_fortress_cell
    end

    # 2. Set Flag to Ranom cell.
    offset_x = (trial.fortress_x_size * FLAG_CELL_OFFSET_SIZE_RATE).ceil
    offset_y = (trial.fortress_y_size * FLAG_CELL_OFFSET_SIZE_RATE).ceil
    flag_cell = TrialFortressCell.where(["trial_id = ? and ? < x and x < ? and ? < y and y < ? and symbol = ?", trial.id, offset_x, trial.fortress_x_size - offset_x, offset_y, trial.fortress_y_size - offset_y, :concrete.to_s]).sample
    flag_cell.goal_flg = true
    flag_cell.save
    p "Goal:(" + flag_cell.x.to_s + "," + flag_cell.y.to_s + ")"
  end

  def self.squad_setup(trial)
    remaining_exit_points = Array.new
    trial.fortress_exit_cells.each do |cell|
      remaining_exit_points << Point.new(cell.x, cell.y)
    end

    current_turn_num = trial.trial_move_turns.length
    current_turn_num = 1 if current_turn_num == 0
    p "current_turn_num:" + current_turn_num.to_s

    # 1. Set up guard squads.
    trial.guard_mission.squads.each_with_index do |squad, index|
      next if squad.entried?
      next if trial.guard_mission.strategy.squad(index + 1).entry_turn != current_turn_num
      p squad.name + "is entried."
      squad.entry
      squad.divide_to_guard
      trial_squad_setup(trial, trial.guard_mission, squad)
      squad_deployed_cell = FortressCell.find_by_mini_map_id_and_squad_id(trial.mini_map_id, squad.id)
      squad.set_current_point(squad_deployed_cell.x, squad_deployed_cell.y) unless squad_deployed_cell.blank?
      squad.destination_point = squad.current_point
      # p squad.current_point
    end

    # 2. Set up intruder squads.
    trial.intruder_mission.squads.each_with_index do |squad, index|
      next if squad.entried?
      next if trial.intruder_mission.strategy.squad(index + 1).entry_turn != current_turn_num
      p squad.name + "is entried."
      squad.entry
      squad.divide_to_intruder
      trial_squad_setup(trial, trial.intruder_mission, squad)
      squad_deployed_point = remaining_exit_points.shuffle.first
      # p "delete"
      # p squad_deployed_point
      remaining_exit_points.delete(squad_deployed_point)
      squad.set_current_point(squad_deployed_point.x, squad_deployed_point.y) unless squad_deployed_point.blank?
      flag_cell = TrialFortressCell.find_by_trial_id_and_goal_flg(trial.id, true)
      squad.destination_point = trial.fortress_goal_point
      # p squad.current_point
      # p squad.destination_point
      squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
      # p squad.route_path
      # p squad.current_point
    end
  end

  def self.trial_squad_setup(trial, mission, squad)
    trial_squad = TrialSquad.new
    trial_squad.trial_id = trial.id
    trial_squad.squad_id = squad.id
    trial_squad.name = squad.name
    trial_squad.save
    trial.trial_squads << trial_squad

    squad.mobs.each do |mob|
      mob.job_type_strategy = mission.strategy.jobtype(mob.job.type_symbol.to_sym)
      trial_mob = TrialMob.new
      trial_mob.trial_squad_id = trial_squad.id
      trial_mob.mob_id = mob.id
      trial_mob.name = mob.name
      trial_mob.job_name = mob.job.name
      trial_mob.max_hp = mob.max_hp
      trial_mob.max_sp = mob.max_sp
      trial_mob.save
      trial_squad.trial_mobs << trial_mob
      mob.trial_mob_id = trial_mob.id
    end
  end

  def self.proceed_turn(trial)
    move_turn = TrialMoveTurn.new(:trial_id => trial.id)
    move_turn.save
    trial.trial_move_turns << move_turn
    # p trial.active_squads

    # 1. Initialize TrialSquadTrail and TrialMobStatus.
    trial.active_squads.each do |squad|
      if squad.intruder?
        squad.enemy_squads = trial.active_guard_squads
        squad.friend_squads = trial.active_intruder_squads
      else
        squad.enemy_squads = trial.active_intruder_squads
        squad.friend_squads = trial.active_guard_squads
      end
    end

    # 2. Move Loop until battle is happen.
    is_move_phase_ended = false
    battle_sets = Array.new
    action_squads = trial.dex_sorted_squads

    index = 0
    until is_move_phase_ended
      action_squads.each do |squad|
        #p squad.name + "(ss_dex:" + squad.ss_dex.to_s + ")"
        if squad.action_turn?
          # 1. Move phase
          # p squad.name + ".act?"
          if squad.demoralized? and squad.destination_point != trial.nearest_fortress_exit_point(squad.current_point)
            squad.target_squad = nil
            squad.destination_point = trial.nearest_fortress_exit_point(squad.current_point)
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
          elsif squad.enemy_squad_sighted? and squad.target_squad != squad.nearest_enemy_squad
            squad.target_squad = squad.nearest_enemy_squad
            squad.destination_point = squad.target_squad.current_point
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
          elsif not squad.enemy_squad_sighted? and not squad.target_squad.blank? and squad.intruder?
            squad.target_squad = nil
            squad.destination_point = trial.fortress_goal_point
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
          end

          trail_log = "Target of " + squad.name + " is "
          trail_log += "(" + squad.destination_point.x.to_s + "," + squad.destination_point.y.to_s + ")."
          trail_log += " Moved from (" + squad.current_point.x.to_s + "," + squad.current_point.y.to_s + ") "

          next_point = squad.current_point
          if not squad.route_path.blank? and not squad.destination_point.equal?(squad.current_point)

            squad_trail = TrialSquadTrail.new
            squad_trail.trial_move_turn_id = move_turn.id
            squad_trail.trial_squad_id = TrialSquad.find_by_squad_id(squad.id)
            squad_trail.from_x = Marshal.load(Marshal.dump(squad.current_point.x))
            squad_trail.from_y = Marshal.load(Marshal.dump(squad.current_point.y))

            squad.route_path.shift
            next_point = squad.route_path.first unless squad.route_path.blank?
            squad.current_point = next_point

            squad_trail.to_x = Marshal.load(Marshal.dump(next_point.x))
            squad_trail.to_y = Marshal.load(Marshal.dump(next_point.y))
            squad_trail.save
            move_turn.trial_squad_trails << squad_trail
          end

          trail_log += " to (" + next_point.x.to_s + "," + next_point.y.to_s + ") "
          p trail_log

          # Goal was occupied by intruders
          if squad.current_point.equal?(trial.fortress_goal_point)
            p "Goal has been occupied by intruders."
            is_move_phase_ended = true 
          end

          # 2. Trap phase

          # 3. Treasure search phase

          # 4. Battle encounter phase
          if squad.enemy_squad_in_battle_range?
            p squad.name + " is going to start a battle."
            battle_sets << {:atk_squad => squad, :def_squad => squad.target_squad, :distance => squad.target_squad.distance_from_current_point }
          end
        end
        is_move_phase_ended = true if battle_sets.length > 0
      end
      index += 1
      is_move_phase_ended = true if index > 100
      break if trial.ended?
    end

    battle_sets.each do |battle_set|
      TrialBattleUpdater.execute(move_turn, battle_set[:atk_squad], battle_set[:def_squad], battle_set[:distance])
    end

    (trial.guard_mission.squads + trial.intruder_mission.squads).each do |squad|
      squad.mobs.each do |mob|
        mob_status = TrialMobStatus.new
        mob_status.trial_move_turn_id = move_turn.id
        mob_status.trial_mob_id = mob.trial_mob_id
        mob_status.end_hp = mob.hp
        mob_status.end_sp = mob.sp
        mob_status.save
        move_turn.trial_mob_statuses << mob_status
      end
    end
  end
end