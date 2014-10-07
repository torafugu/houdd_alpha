# This class describes a mob.
class Mob < ActiveRecord::Base
  belongs_to :houdd_user
  belongs_to :specie
  belongs_to :job
  belongs_to :squad
  belongs_to :father, :class_name => 'Mob', :foreign_key => :father_id
  belongs_to :mother, :class_name => 'Mob', :foreign_key => :mother_id

  has_many :dnas
  has_many :items
  has_many :item_info_exp_invs, :dependent => :delete_all
  has_many :skill_exp_invs, :dependent => :delete_all

  validates :specie_id, :numericality => {:only_integer => true}
  validates :father_id, :numericality => {:only_integer => true, :allow_blank => true}
  validates :mother_id, :numericality => {:only_integer => true, :allow_blank => true}
  validates :generation, :numericality => {:only_integer => true, :allow_blank => true}
  validates :job_id, :numericality => {:only_integer => true}
  validates :squad_id, :numericality => {:only_integer => true, :allow_blank => true}
  validates :name, :presence => true
  validates :gender_sym, format: { with: /\A[a-zA-Z]+\z/ }
  validates :age, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => Params::MOB_AGE_MAX}
  validates :hp, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :sp, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :str, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :dex, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :con, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :int, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :wis, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :cha, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :phys_def, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :skill_def, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => Params::MOB_STATUS_MAX}
  validates :ele_fw, :numericality => {:only_integer => true, :greater_than_or_equal_to => Params::MOB_ELEMENT_MIN, :less_than_or_equal_to => Params::MOB_ELEMENT_MAX}
  validates :ele_ld, :numericality => {:only_integer => true, :greater_than_or_equal_to => Params::MOB_ELEMENT_MIN, :less_than_or_equal_to => Params::MOB_ELEMENT_MAX}

  # This Struct describes an inventory of battle effect.
  BattleEffectInv = Struct.new(:caused_mob, :method, :remaining_duration)

  attr_accessor :job_type_strategy
  attr_accessor :trial_mob_id
  attr_accessor :enemy_mobs
  attr_accessor :friend_mobs
  attr_accessor :ss_dex
  attr_accessor :vpos
  attr_accessor :hate
  attr_accessor :battle_effect_invs
  attr_accessor :attacker
  attr_accessor :intruder

  # Maximum priority of battle method.
  MAX_PRIORITY = 5

  # Return name with job name.
  # @return [String]
  def name_with_job
    return name + "(" + job.name + ")"
  end

  # Return name with job name and squad name.
  # @return [String]
  def name_with_job_and_squad
    battle_side_txt = I18n.t('activerecord.messages.guards')
    battle_side_txt = I18n.t('activerecord.messages.intruder') if intruder
    return '(' + battle_side_txt + ')' + squad.name + "-" + name_with_job
  end

  # Return true if this mob is female.
  # @return [Boolean]
  def female?
    return true if gender_sym.to_sym == Params::GENDER_FEMALE
    return false
  end

  # Return true if this mob is asexual.
  # @return [Boolean]
  def asexual?
    return true if gender_sym.to_sym == Params::GENDER_ASEXUAL
    return false
  end

  # Return the description of gender symbol.
  # @return [String]
  def gender_sym_txt
    return I18n.t('activerecord.attributes.gender.' + gender_sym)
  end

  # Return maximum hp.
  # @note maximum hp is calculated from CON status.
  # @return [Integer].
  def max_hp
    return con * Params::MOB_MAX_HP_MULTIPLIER
  end

  # Return maximum sp.
  # @note maximum sp is calculated from INT status.
  # @return [Integer].
  def max_sp
    return int * Params::MOB_MAX_SP_MULTIPLIER
  end

  # Return true if current hp is less than retreat_hp_rate.
  # @return [Boolean].
  def demoralized?
    return true if hp < max_hp * @job_type_strategy.retreat_hp_rate
    return false
  end

  # Return equipped weapon.
  # @return [Object].
  def weapon
    items.each do |item|
      return item if item.item_info.type_symbol == :weapon.to_s
    end

    natural_item = Item.new
    specie.family.item_infos.each do |item_info|
      if item_info.type_symbol == :natural_weapon.to_s
        natural_item.mob_id = id
        natural_item.houdd_user_id= houdd_user_id
        natural_item.item_info_id= item_info.id
        natural_item.dp = item_info.max_dp
        natural_item.quality = 0
        natural_item.built_point = item_info.rq_prod_point
        natural_item.active_flg = true
        return natural_item
      end
    end

    return nil
  end

  # Return equipped armor.
  # @return [Object].
  def armor
    items.each do |item|
      return item if item.item_info.type_symbol == :armor.to_s
    end
    return nil
  end

  # Return the item list which belongs to this mob.
  # @return [String] Comma separated item.name
  def equipped_items_txt
    return I18n.t('activerecord.attributes.nothing') if items.blank?
    items_txt = ''
    items.each do |item|
      if not item.blank?
        items_txt += item.name
        items_txt += ','
      end
    end
    items_txt.chop! if items_txt.last == ','
    return items_txt
  end

  # Return all the skills.
  # @return [Array].
  def skills
    all_skills = Array.new
    all_skills += job.skills unless job.skills.blank?
    all_skills << specie.skill unless specie.skill.blank?
    all_skills << specie.family.skill unless specie.family.skill.blank?
    return all_skills
  end

  # Return battle range.
  # @return [Integer].
  def battle_range
    range = 1
    skills.each do |skill|
      range = skill.range if range < skill.range and (skill.type_symbol == :dd.to_s or skill.type_symbol == :dot.to_s)
    end
    items.each do |item|
      range = item.item_info.range if range < item.item_info.range and item.item_info.type_symbol == :weapon.to_s
    end
    return range
  end

  # Return true if forward job.
  # @note Tank and Close range attacker.
  # @return [Boolean].
  def forward_job?
    return true if job.type_symbol == :tank.to_s or job.type_symbol == :attacker_c.to_s
    return false
  end

  # Vertical move.
  # @note moving logic depends on job.
  def vpos_move
    if @attacker
      if demoralized?
        @vpos -= 1
      elsif not forward_job? and on_front_line?
        @vpos -= 1 if Params::BATTLE_START_ATK_VPOS <= @vpos - 1
      elsif job_type_strategy.vpos - @vpos < 0
        @vpos -= 1 if Params::BATTLE_START_ATK_VPOS <= @vpos - 1
      elsif job_type_strategy.vpos - @vpos > 0
        @vpos += 1 unless on_front_line?
      end
    else
      if demoralized?
        @vpos += 1
      elsif not forward_job? and on_front_line?
        @vpos += 1 if @vpos + 1 <= Params::BATTLE_START_ATK_VPOS + 1
      elsif (Params::BATTLE_START_DEF_VPOS - job_type_strategy.vpos + 1) - @vpos > 0
        @vpos += 1 if @vpos + 1 <= Params::BATTLE_START_ATK_VPOS + 1
      elsif (Params::BATTLE_START_DEF_VPOS - job_type_strategy.vpos + 1) - @vpos < 0
        @vpos -= 1 unless on_front_line?
      end
    end
  end

  # Return true if this mob is facing enemy.
  # @return [Boolean].
  def on_front_line?
    front_line_vpos = Params::BATTLE_START_DEF_VPOS
    @enemy_mobs.each do |enemy_mob|
      unless enemy_mob.dead?
        distance_from_enemy = (enemy_mob.vpos - @vpos).abs
        front_line_vpos = distance_from_enemy if distance_from_enemy < front_line_vpos
      end
    end
    return false if front_line_vpos > 1
    return true
  end

  # Return true if the nearest enemy mob is in battle range.
  # @return [Boolean].
  def enemy_mobs_in_battle_range?(range)
    return true unless enemy_mobs_in_battle_range(range).blank?
    return false
  end

  # Return true if the nearest friend mob is in battle range.
  # @return [Boolean].
  def friend_mobs_in_battle_range?(range)
    return true unless friend_mobs_in_battle_range(range).blank?
    return false
  end

  # Return true if the nearest damaged friend mob is in battle range.
  # @return [Boolean].
  def damaged_friend_mobs_in_battle_range?(range)
    return true unless damaged_friend_mobs_in_battle_range(range).blank?
    return false
  end

  # Set out-ranged vpos.
  def retreat_from_battle
    if @attacker
      @vpos = Params::BATTLE_START_ATK_VPOS + 1
    else
      @vpos = Params::BATTLE_START_DEF_VPOS - 1
    end
  end

  # Return true if this mob has already retreated.
  # @return [Boolean].
  def retreated_from_battle?
    return false if @vpos.nil?
    return true if @vpos < Params::BATTLE_START_ATK_VPOS or Params::BATTLE_START_DEF_VPOS < @vpos
    false
  end

  # Return true if this mob is dead.
  # @return [Boolean].
  def dead?
    return true if hp == 0
    false
  end

  # Return random battle action.
  # @return [Object].
  def battle_action
    1.upto(MAX_PRIORITY) do |priority|
      prioritized_methods = Marshal.load(Marshal.dump(@job_type_strategy.battle(:normal).methods_by_priority(priority)))

      unless prioritized_methods.blank?
        battle_method = prioritized_methods.delete_at(rand(prioritized_methods.length))
        if battle_method.battle_type == :weapon
          return nil if weapon.blank?
          if enemy_mobs_in_battle_range?(weapon.range)
            battle_method.method = weapon
            return battle_method
          end
        elsif battle_method.battle_type == :skill
          if battle_method.type_symbol == :dd or battle_method.type_symbol == :dot or battle_method.type_symbol == :debuff
            skills.shuffle.each do |skill|
              if (skill.type_symbol == :dd.to_s or skill.type_symbol == :dot.to_s or skill.type_symbol == :debuff.to_s) and enemy_mobs_in_battle_range?(skill.range) and skill.sp_cost <= sp
                battle_method.method = skill
                return battle_method
              end
            end
          elsif battle_method.type_symbol == :hd or battle_method.type_symbol == :hot
            skills.shuffle.each do |skill|
              if (skill.type_symbol == :hd.to_s or skill.type_symbol == :hot.to_s) and damaged_friend_mobs_in_battle_range?(skill.range) and skill.sp_cost <= sp
                battle_method.method = skill
                return battle_method
              end
            end
          elsif battle_method.type_symbol == :buff or battle_method.type_symbol == :other
            skills.shuffle.each do |skill|
              if (skill.type_symbol == :buff.to_s or skill.type_symbol == :other.to_s) and friend_mobs_in_battle_range?(skill.range) and skill.sp_cost <= sp
                battle_method.method = skill
                return battle_method
              end
            end
          end
        end
      end
    end
    return nil
  end

  # Return target enemy mobs in battle range.
  # @note returned mobs are sorted by hate.
  # @return [Array].
  def target_enemy_mobs(range, num)
    sorted_enemy_mobs_in_battle_range = enemy_mobs_in_battle_range(range).sort{|a,b|
      b.hate <=> a.hate
    }

    if sorted_enemy_mobs_in_battle_range.length <= num
      return sorted_enemy_mobs_in_battle_range
    else
      sorted_enemy_mobs_in_battle_range.slice(0..(num - 1))
    end
  end

  # Return target friend mobs which are damaged in battle range.
  # @note returned mobs are sorted by hp.
  # @return [Array].
  def target_damaged_friend_mobs(range, num)

    return [self] if range == 0

    sorted_damaged_friend_mobs_in_battle_range = damaged_friend_mobs_in_battle_range(range).sort{|a,b|
      a.hp <=> a.hp
    }

    if sorted_damaged_friend_mobs_in_battle_range.length <= num
      return sorted_damaged_friend_mobs_in_battle_range
    else
      sorted_damaged_friend_mobs_in_battle_range.slice(0..(num - 1))
    end
  end

  # Return target friend mobs which are selected randomly in battle range.
  # @return [Array].
  def target_random_friend_mobs(range, num)

    return [self] if range == 0

    friend_mobs_in_battle_range = friend_mobs_in_battle_range(range)
    
    if friend_mobs_in_battle_range.length <= num
      return friend_mobs_in_battle_range.shuffle
    else
      return friend_mobs_in_battle_range.shuffle.slice(0..(num - 1))
    end
  end

  # Add exp for used weapon in battle.
  # @param [Integer] exp
  def add_weapon_exp(exp)
    if item_info_exp_invs.blank? or item_info_exp_invs.find_by_owner_id(weapon.item_info_id).blank?
      weapon_exp = ItemInfoExpInv.new
      weapon_exp.mob_id = id
      weapon_exp.owner_id = weapon.item_info_id
      weapon_exp.level = 1
      weapon_exp.exp = exp
      weapon_exp.save
    else
      weapon_exp = item_info_exp_invs.find_by_owner_id(weapon.item_info_id)
      weapon_exp.exp += exp
      weapon_exp.save
    end
  end

  # Add exp for used skill in battle.
  # @param [Object] skill
  # @param [Integer] exp
  def add_skill_exp(skill, exp)
    return if not skills.include?(skill)
    if skill_exp_invs.blank? or skill_exp_invs.find_by_owner_id(skill.id).blank?
      skill_exp = SkillExpInv.new
      skill_exp.mob_id = id
      skill_exp.owner_id = skill.id
      skill_exp.level = 1
      skill_exp.exp = exp
      skill_exp.save
    else
      skill_exp = skill_exp_invs.find_by_owner_id(skill.id)
      skill_exp.exp += exp
      skill_exp.save
    end
  end

  # Add battle effect.
  # @note By DoT or HoT
  # @param [Object] caused_mob
  # @param [Object] method
  def add_effect(caused_mob, method)
    @battle_effect_invs = Array.new if @battle_effect_invs.blank?
    @battle_effect_invs.each do |battle_effect_inv|
      return if battle_effect_inv.method.id == method.id
    end
    @battle_effect_invs << BattleEffectInv.new(caused_mob, method, method.duration)
  end

  private

  def enemy_mobs_in_battle_range(range)
    reachable_enemy_mobs = Array.new
    @enemy_mobs.each do |enemy_mob|
      if (1 < range or (enemy_mob.vpos - @vpos).abs == 1) and not enemy_mob.dead? and not enemy_mob.retreated_from_battle?
        reachable_enemy_mobs << enemy_mob
      end
    end
    return reachable_enemy_mobs
  end

  def friend_mobs_in_battle_range(range)
    reachable_friend_mobs = Array.new
    @friend_mobs.each do |friend_mob|
      if (1 < range or (friend_mob.vpos - @vpos).abs <= 1) and not friend_mob.dead? and not friend_mob.retreated_from_battle?
        reachable_friend_mobs << friend_mob
      end
    end
    return reachable_friend_mobs
  end

  def damaged_friend_mobs_in_battle_range(range)
    reachable_damaged_friend_mobs = Array.new
    @friend_mobs.each do |friend_mob|
      if (1 < range or (friend_mob.vpos - @vpos).abs <= 1) and not friend_mob.dead? and not friend_mob.retreated_from_battle? and friend_mob.hp < friend_mob.max_hp
        reachable_damaged_friend_mobs << friend_mob
      end
    end
    return reachable_damaged_friend_mobs
  end


end
