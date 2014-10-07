# This class is updater of Trial.
class TrialUpdater

  # Return value in case trial completed successfully.
  NORMAL_END = 0

  # Return value in case trial completed abnormally.
  ABNORMAL_END = -1

  # Offset size of setting flag in fortress.
  FLAG_CELL_OFFSET_SIZE_RATE = 0.2

  # Max trial turn in a battle set.
  MAX_TRIAL_TURN = 50

  # Max loop size until time out is happen.
  MAX_LOOP_INDEX = 500

  # Max movement distance in a trial turn.
  MAX_MOVE_INDEX = 15

  # Rate of disarming trap.
  DISARM_BASE_RATE = 50

  # execute trial updating.
  # @note TrialDeleter is called before executing.
  def self.execute_debug
    Trial.all.each do |trial|
      TrialDeleter.execute(trial.id)
    end
    execute
  end

  # execute trial updating.
  def self.execute
    Trial.find_all_by_occurred_at(nil).each do |trial|
      prepare(trial)
      turn_num = 1
      until (trial.guard_defeated? or trial.intruder_defeated? or trial.goal_was_occupied) and 2 < turn_num
      #5.times do |turn_num|
        squad_setup(trial)
        #break if trial.active_squads.blank?
        p '-- proceed_turn ' + (turn_num).to_s + ' --'
        proceed_turn(trial)
        turn_num += 1
        break if turn_num > MAX_TRIAL_TURN
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
      trial_fortress_cell.goal_flg = false
      if cell.trap_id.blank?
        trial_fortress_cell.trap_flg = false
      else
        trial_fortress_cell.trap_flg = true
      end
      trial_fortress_cell.save
      trial.trial_fortress_cells << trial_fortress_cell
    end

    # 2. Set Flag to Random cell.
    offset_x = (trial.fortress_x_size * FLAG_CELL_OFFSET_SIZE_RATE).ceil
    offset_y = (trial.fortress_y_size * FLAG_CELL_OFFSET_SIZE_RATE).ceil
    flag_cell = TrialFortressCell.where(["trial_id = ? and ? < x and x < ? and ? < y and y < ? and symbol = ?", trial.id, offset_x, trial.fortress_x_size - offset_x, offset_y, trial.fortress_y_size - offset_y, :concrete.to_s]).sample
    flag_cell.goal_flg = true
    flag_cell.save
    p 'Goal:(' + flag_cell.x.to_s + ',' + flag_cell.y.to_s + ')'
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
      next if squad.entried
      next if trial.guard_mission.strategy.squad(index + 1).entry_turn != current_turn_num
      p squad.name + 'is entried.'
      squad.entried = true
      squad.intruder = false
      trial_squad_setup(trial, trial.guard_mission, squad)
      # print 'Mob size is ' + squad.mobs.size.to_s + "\n"
      squad_deployed_cell = FortressCell.find_by_mini_map_id_and_squad_id(trial.mini_map_id, squad.id)

      if squad_deployed_cell.blank?
        if trial.goal_cell_guarded?
          random_point = trial.fortress_random_point
          # TODO duplicated deployment should be checked.
          squad.current_point = Point.new(random_point.x, random_point.y)
        else
          goal_point = trial.fortress_goal_point
          squad.current_point = Point.new(goal_point.x, goal_point.y)
        end
        # if flag cell is not occupied, must be set up first.
      else
        squad.current_point = Point.new(squad_deployed_cell.x, squad_deployed_cell.y) unless squad_deployed_cell.blank?
      end

      squad.destination_point = squad.current_point
      # p squad.current_point
    end

    # 2. Set up intruder squads.
    trial.intruder_mission.squads.each_with_index do |squad, index|
      next if squad.entried
      next if trial.intruder_mission.strategy.squad(index + 1).entry_turn > current_turn_num
      next if remaining_exit_points.blank?

      p squad.name + "is entried."
      squad.entried = true
      squad.intruder = true
      trial_squad_setup(trial, trial.intruder_mission, squad)
      # print 'Mob size is ' + squad.mobs.size.to_s + "\n"
      squad_deployed_point = remaining_exit_points.shuffle.first
      # p "delete squad_deployed_point"
      # p "squad_deployed_point:"
      # p squad_deployed_point
      remaining_exit_points.delete(squad_deployed_point)
      squad.current_point = Point.new(squad_deployed_point.x, squad_deployed_point.y) unless squad_deployed_point.blank?
      squad.destination_point = trial.fortress_goal_point
      # p "current_point:"
      # p squad.current_point
      # p "destination_point:"
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
    trial_squad.intruder_flg = squad.intruder
    trial_squad.save
    trial.trial_squads << trial_squad
    squad.trial_squad_id = trial_squad.id

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
    move_turn.log = ''
    move_turn.save
    trial.trial_move_turns << move_turn
    # p trial.active_squads

    # 1. Initialize TrialSquadTrail
    trial.active_squads.each do |squad|
      if squad.intruder
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
    moved_squads = Array.new

    loop_index = 0
    move_index = 0
    until is_move_phase_ended
      action_squads.each do |squad|
        #p squad.name + "(ss_dex:" + squad.ss_dex.to_s + ")"
        if squad.action_turn?
          # Move phase
          # p squad.name + ".act?"
          # p "enemy_squads:"
          # p squad.enemy_squads
          if squad.demoralized? and not squad.destination_point.equal?(trial.nearest_fortress_exit_point(squad.current_point))
            squad.target_squad = nil
            squad.destination_point = trial.nearest_fortress_exit_point(squad.current_point)
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
            p squad.name + ' is demoralized.'
          elsif squad.enemy_squad_sighted? and squad.target_squad != squad.nearest_enemy_squad
            squad.target_squad = squad.nearest_enemy_squad
            squad.destination_point = squad.target_squad.current_point
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
            p squad.name + ' sighted '  + squad.target_squad.name + '.'
          elsif not squad.enemy_squad_sighted? and not squad.target_squad.blank? and squad.intruder
            squad.target_squad = nil
            squad.destination_point = trial.fortress_goal_point
            squad.route_path = RouteRetriever.execute(trial, squad.current_point, squad.destination_point)
            p squad.name + ' does not have a target.'
          end

          trail_log = 'Target of ' + squad.name + ' is '
          if squad.target_squad.blank?
            trail_log += 'Goal'
          else
            trail_log += squad.target_squad.name
          end
          trail_log += '(' + squad.destination_point.x.to_s + ',' + squad.destination_point.y.to_s + ').'
          trail_log += ' Moved from (' + squad.current_point.x.to_s + ',' + squad.current_point.y.to_s + ') '

          if not squad.route_path.blank? and not squad.destination_point.equal?(squad.current_point)
            squad_trail = TrialSquadTrail.new
            squad_trail.trial_move_turn_id = move_turn.id
            squad_trail.trial_squad_id = TrialSquad.find_by_trial_id_and_squad_id(trial.id, squad.id).id
            squad_trail.from_x = Marshal.load(Marshal.dump(squad.current_point.x))
            squad_trail.from_y = Marshal.load(Marshal.dump(squad.current_point.y))

            route_start_point = squad.route_path.shift

            if squad.route_path.blank? or occupied?(squad.route_path.first, action_squads - [squad])
              squad.route_path.unshift route_start_point
            else
              squad.current_point = squad.route_path.first
              squad_trail.to_x = Marshal.load(Marshal.dump(squad.route_path.first.x))
              squad_trail.to_y = Marshal.load(Marshal.dump(squad.route_path.first.y))
              squad_trail.save
              move_turn.trial_squad_trails << squad_trail
              move_index += 1
              moved_squads << squad unless moved_squads.include?(squad)
              trail_log += ' to (' + squad.route_path.first.x.to_s + ',' + squad.route_path.first.y.to_s + ').'
              p trail_log
            end
          end

          # After move phase
          # 1. Trap phase
          trap = trial.fortress_cell_trap(squad.current_point)
          unless trap.blank?
            attempt_roll = rand(Params::PERCENT_DENOMINATOR)
            # TODO disarm rate change for job.
            if DISARM_BASE_RATE < attempt_roll
              trap.dp = dp
              trap.save
              p squad.name + ' was faced a trap but disarmed.'
              move_turn.log = I18n.t('activerecord.messages.trap_disarmed', :name => squad.name)
            else
              trap.dp -= 1
              trap.save
              p squad.name + ' was faced a trap.'
              move_turn.log = I18n.t('activerecord.messages.trap_not_disarmed', :name => squad.name)

              extract_mob_num = trap.item_info.num_of_tgt
              extract_mob_num = squad.living_mobs.length if squad.living_mobs.length < extract_mob_num
              attacked_mobs = squad.living_mobs.sample(extract_mob_num)
              attacked_mobs.each do |mob|
                # TODO Trap damage should be calculated more precisely.
                mob.hp -= (trap.damage / 3).ceil
                mob.hp = 0 if mob.hp < 0
                p 'target_mob hp was damaged by ' + damage.to_s + ", current hp is " + mob.hp.to_s
              end
            end
          end

          # 2. Occupy goal phase
          if squad.intruder and squad.current_point.equal?(trial.fortress_goal_point)
            p 'Goal has been occupied by intruders.'
            move_turn.log = I18n.t('activerecord.messages.goal_occupied')
            trial.goal_was_occupied = true
            is_move_phase_ended = true
          end

          # 3. Retreat phase
          if squad.demoralized? and squad.current_point.equal?(trial.nearest_fortress_exit_point(squad.current_point))
            squad.retreated_from_fortress = true
            p squad.name + ' was retreated from fortress.'
            move_turn.log += I18n.t('activerecord.messages.retreated_from_fortress', :name => squad.name) + "\n"
          end

          # 4. Battle encounter phase
          if squad.enemy_squad_in_battle_range?
            distance = squad.target_squad.distance_from_current_point.ceil
            battle_encounter_message = squad.name + ' is going to start a battle with ' + squad.target_squad.name + '.'
            battle_encounter_message += 'The distance is ' + distance.to_s + '.'
            p battle_encounter_message
            move_turn.log += I18n.t('activerecord.messages.battle_encounter', :name1 => squad.name, :name2 => squad.target_squad.name) + "\n"
            battle_sets << {:atk_squad => squad, :def_squad => squad.target_squad, :distance => distance}
            is_move_phase_ended = true
          end
        end
      end

      loop_index += 1
      if loop_index > MAX_LOOP_INDEX
        p 'Move turn ended due to time out.'
        move_turn.log += I18n.t('activerecord.messages.move_turn_end_time_out')
        is_move_phase_ended = true
      elsif move_index > MAX_MOVE_INDEX
        p 'Move turn ended due to movement completed.'
        move_turn.log += I18n.t('activerecord.messages.move_turn_end_movement')
        is_move_phase_ended = true
      elsif trial.guard_defeated?
        p 'Guards were defeated.'
        move_turn.log += I18n.t('activerecord.messages.move_turn_end_guards_defeated')
        is_move_phase_ended = true
      elsif trial.intruder_defeated?
        p 'Intruders were defeated.'
        move_turn.log += I18n.t('activerecord.messages.move_turn_end_intruders_defeated')
        is_move_phase_ended = true
      end
    end

    (action_squads - moved_squads).each do |squad|
      squad_trail = TrialSquadTrail.new
      squad_trail.trial_move_turn_id = move_turn.id
      squad_trail.trial_squad_id = TrialSquad.find_by_trial_id_and_squad_id(trial.id, squad.id).id
      squad_trail.from_x = Marshal.load(Marshal.dump(squad.current_point.x))
      squad_trail.from_y = Marshal.load(Marshal.dump(squad.current_point.y))
      squad_trail.to_x = Marshal.load(Marshal.dump(squad.current_point.x))
      squad_trail.to_y = Marshal.load(Marshal.dump(squad.current_point.y))
      squad_trail.save
      move_turn.trial_squad_trails << squad_trail
      trail_log = squad.name + ' stayed on (' + squad.current_point.x.to_s + ',' + squad.current_point.y.to_s + ').'
      p trail_log
    end

    battle_sets.each do |battle|
      battle_set = TrialBattleSet.new
      battle_set.attacker_squad_id = battle[:atk_squad].trial_squad_id
      battle_set.defender_squad_id = battle[:def_squad].trial_squad_id
      battle_set.distance = battle[:distance]
      battle_set.save
      move_turn.trial_battle_sets << battle_set

      TrialBattleUpdater.execute(battle_set, battle[:atk_squad], battle[:def_squad], battle[:distance])
    end

    move_turn.save
  end

  def self.occupied?(point, squads)
    # print '(' + point.x.to_s + ',' + point.y.to_s + ') is occupied? -> '
    squads.each do |squad|
      # print '(' + squad.current_point.x.to_s + ',' + squad.current_point.y.to_s + ') '
      if point.equal?(squad.current_point)
        # print "True.\n"
        return true
      end
    end
    # print "False.\n"
    return false
  end
end