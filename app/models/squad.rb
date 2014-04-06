# This class describes a squad of mobs.
class Squad < ActiveRecord::Base
  belongs_to :houdd_user
  belongs_to :mini_map
  has_many :mobs

  has_many :missions, :through => :mission_queues
  has_many :mission_queues, :dependent => :delete_all

  validates :houdd_user_id, :presence => true
  validates :name, :presence => true

  attr_accessor :current_point
  attr_accessor :destination_point
  attr_accessor :route_path
  attr_accessor :distance_from_current_point
  attr_accessor :ss_dex
  attr_accessor :enemy_squads
  attr_accessor :friend_squads
  attr_accessor :target_squad

  # Return the mission list which belongs to this squad.
  # @return [String] Comma separated mission.name
  def missions_txt
    missions_txt = ''
    missions.each do |mission|
      if not mission.blank?
        missions_txt += mission.name
        missions_txt += ','
      end
    end
    missions_txt.chop! if missions_txt.last == ','
    return missions_txt
  end

  # Set entry flag as true.
  def entry
    @entry_flg = true
  end

  # Return the status whether entried to fortress or not.
  # @return [Boolean] status.
  def entried?
    @entry_flg = false if @entry_flg.nil?
    return @entry_flg
  end

  # Set intruder flag as true.
  def divide_to_intruder
    @intruder_flg = true
  end

  # Set intruder flag as false.
  def divide_to_guard
    @intruder_flg = false
  end

  # Return true if the member of intruders.
  # @return [Boolean].
  def intruder?
    return @intruder_flg
  end

  # Set current point.
  # @param [Integer] x x-coordinate
  # @param [Integer] y y-coordinate
  def set_current_point(x, y)
    @current_point = Point.new(x, y)
  end

  # Return true if all the mobs belong to this squad are dead.
  # @return [Boolean].
  def annihilated?
    mobs.each do |mob|
      return false if mob.hp > 0
    end
    return true
  end

  # Return true if all the mobs belong to this squad are demoralized.
  # @return [Boolean].
  def demoralized?
    mobs.each do |mob|
      return false unless mob.demoralized?
    end
    return true
  end

  # Set true to @retreated_from_fortress_flg.
  def retreat_from_fortress
    @retreated_from_fortress_flg = true
  end

  # Return true if this squad has already retreated.
  # @return [Boolean].
  def retreatd_from_fortress?
    return false if @retreated_from_fortress_flg.nil?
    return @retreated_from_fortress_flg
  end

  # Return true if this squad can act in trial move turn.
  # @return [Boolean].
  def action_turn?
    return true if not annihilated? and rand(Params::MOB_STATUS_MAX) <= @ss_dex
    return false
  end

  # Return the nearest enemy squad from current point.
  # @return [Object].
  def nearest_enemy_squad
    enemy_squads.each do |enemy_squad|
      enemy_squad.distance_from_current_point = Tools.calc_distance(current_point, enemy_squad.current_point)
    end
    enemy_squads_sorted_by_distance = enemy_squads.sort{|a,b|
      a.distance_from_current_point <=> b.distance_from_current_point
    }
    return enemy_squads_sorted_by_distance.first
  end

  # Return true if the nearest enemy squad is in sight.
  # @return [Boolean].
  def enemy_squad_sighted?
    return false if enemy_squads.blank?
    return true if nearest_enemy_squad.distance_from_current_point <= Params::ENEMY_VISIBLE_DISTANCE
    return false
  end

  # Return battle range.
  # @return [Integer].
  def battle_range
    range = 1
    mobs.each do |mob|
      range = mob.battle_range if range < mob.battle_range - 1 and not mob.dead?
    end
    return range
  end

  # Return true if the nearest enemy squad is in batle range.
  # @return [Boolean].
  def enemy_squad_in_battle_range?
    return false if @target_squad.nil?
    return true if nearest_enemy_squad.distance_from_current_point <= battle_range
    return false
  end

  # Return dex of this squad.
  # @note mimum dex of mobs which belong to this squad.
  # @return [Integer].
  def dex
    dex = Params::MOB_STATUS_MAX
    mobs.each do |mob|
      next if mob.dead?
      dex = mob.dex if dex > mob.dex
    end
    return dex
  end
end
