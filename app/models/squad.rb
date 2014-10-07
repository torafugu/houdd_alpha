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
  attr_accessor :intruder
  attr_accessor :entried
  attr_accessor :trial_squad_id
  attr_accessor :retreated_from_fortress

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

  # Return true if all the mobs belong to this squad are retreated from battle.
  # @return [Boolean].
  def retreated_from_battle?
    mobs.each do |mob|
      return false if not mob.retreated_from_battle? and not mob.dead?
    end
    return true
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
      # p current_point
      # p enemy_squad.current_point
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
    return false if @enemy_squads.blank?
    return true if nearest_enemy_squad.distance_from_current_point <= Params::ENEMY_VISIBLE_DISTANCE
    return false
  end

  # Return battle range.
  # @return [Integer].
  def battle_range
    range = 1
    mobs.each do |mob|
      next if mob.dead?
      range = mob.battle_range if range < mob.battle_range
    end
    return range
  end

  # Return true if the nearest enemy squad is in battle range.
  # @return [Boolean].
  def enemy_squad_in_battle_range?
    return false if @target_squad.nil?
    return true if nearest_enemy_squad.distance_from_current_point == 1
    return true if nearest_enemy_squad.distance_from_current_point.ceil < battle_range
    return false
  end

  # Return dex of this squad.
  # @note minimum dex of mobs which belong to this squad.
  # @return [Integer].
  def dex
    dex = Params::MOB_STATUS_MAX
    mobs.each do |mob|
      next if mob.dead?
      dex = mob.dex if dex > mob.dex
    end
    return dex
  end

  # Return the damaged hp ratio of all mobs.
  # @return [Integer].
  def damaged_hp_rate
    total_mob_max_hp = 0
    total_mob_current_hp = 0

    mobs.each do |mob|
      total_mob_max_hp += mob.max_hp
      total_mob_current_hp += mob.hp
    end

    total_mob_max_hp / total_mob_current_hp
  end

  # Return all the mobs which is not yet dead.
  # @return [Array].
  def living_mobs
    living_mobs = Array.new
    mobs.each do |mob|
      living_mobs << mob unless mob.dead?
    end
    return living_mobs
  end
end
