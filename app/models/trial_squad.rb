# This class describes a squad for trial.
class TrialSquad < ActiveRecord::Base
  belongs_to :trial
  has_many :trial_mobs, :dependent => :delete_all
  has_many :trial_squad_trails, :dependent => :delete_all

  attr_accessible :intruder_flg, :name, :squad_id

  # This trail is starting point.
  STARTING = 1

  # This trail is stop over point.
  STOP_OVER = 2

  # This trail is terminal point.
  TERMINAL = 3

  # This trail is stating and terminal point.
  STARTING_TERMINAL = 4

  # Return trial_squad_trails of particular move_turn.
  # @param [Object] trial_move_turn.
  # @return [Array] trial_squad_trails.
  def trails_of_move_turn(trial_move_turn)
    trails = Array.new
    trial_squad_trails.each do |trail|
      trails << trail if trail.trial_move_turn_id == trial_move_turn.id
    end
    trails.each_with_index do |trail, i|
      if i == 0 and trails.size != 1
        trail.trail_type = STARTING
      elsif i == 0 and trails.size == 1
        if trail.from_x == trail.to_x and trail.from_y == trail.to_y
          trail.trail_type = STARTING
        else
          trail.trail_type = STARTING_TERMINAL
        end
      elsif i == trails.size - 1
        trail.trail_type = TERMINAL
      else
        trail.trail_type = STOP_OVER
      end
      trail.intruder_flg = intruder_flg
      trail.annihilated_flg = annihilated?
    end
    return trails
  end

  # Return true if all the mobs belong to this squad are dead.
  # @return [Boolean].
  def annihilated?
    trial_mobs.each do |trial_mob|
      return false if trial_mob.hp > 0
    end
    return true
  end
end
