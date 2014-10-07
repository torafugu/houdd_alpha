# This class select missions for trial.
class MissionMatcher

  # Execute match making.
  # The condition of creating trial is following.
  # 1. intruder_mission and guard_mission are not blank.
  # 2. Both missions are in same mini map.
  # 3. Both missions have 'on_going' status.
  def self.execute

    current_day = HouddHistory.last.day

    Mission.all.each do |mission|
      if current_day <= mission.start_houdd_time and mission.status_symbol == :not_start.to_s
        mission.status_symbol = :on_going.to_s
        mission.save
      elsif mission.end_houdd_time < current_day and mission.status_symbol == :on_going.to_s
        mission.status_symbol = :completed.to_s
        mission.save
      end
    end

    MiniMap.all.each do |mini_map|

      guard_mission = Mission.find_all_by_mini_map_id_and_status_symbol_and_category_symbol(mini_map.id, :on_going.to_s, :guard.to_s).sample
      intruder_mission = Mission.find_all_by_mini_map_id_and_status_symbol_and_category_symbol(mini_map.id, :on_going.to_s, :intrude.to_s).sample

      if intruder_mission.blank? or guard_mission.blank?
        next
      else
        trial = Trial.new
        trial.mini_map_id = mini_map.id
        trial.map_name = mini_map.name
        trial.guard_mission_id = guard_mission.id
        trial.intruder_mission_id = intruder_mission.id
        trial.save
      end
    end
  end
end