# This class is updater of Battle in Trial.
class TrialBattleUpdater

  # Modifier value if no parameter is provided.
  BASE_MOD = 1

  # method_txt value in case of Set-up phase.
  # SET_UP_TXT = 'SETUP'

  def self.execute(battle_set, atk_squad, def_squad, distance)
    # p "Battle of " + atk_squad.id.to_s + "," + def_squad.id.to_s + "," + distance.to_s

    # Set-up phase
    atk_squad.mobs.each do |mob|
      mob.enemy_mobs = def_squad.mobs
      mob.friend_mobs = atk_squad.mobs
      mob.attacker = true
      mob.intruder = atk_squad.intruder
      mob.hate = 0

      if mob.forward_job?
        mob.vpos = Params::BATTLE_START_ATK_VPOS + 1
      else
        mob.vpos = Params::BATTLE_START_ATK_VPOS
      end
    end

    def_squad.mobs.each do |mob|
      mob.enemy_mobs = atk_squad.mobs
      mob.friend_mobs = def_squad.mobs
      mob.attacker = false
      mob.intruder = def_squad.intruder
      mob.hate = 0

      if mob.forward_job?
        mob.vpos = Params::BATTLE_START_DEF_VPOS - 1
      else
        mob.vpos = Params::BATTLE_START_DEF_VPOS
      end
    end

    battle_ended_flg = false
    loop_index = 0
    until battle_ended_flg
      battle_turn = TrialBattleTurn.new
      battle_turn.trial_battle_set_id = battle_set.id
      battle_turn.log = ''
      battle_turn.save

      (atk_squad.mobs + def_squad.mobs).each do |mob|
        mob_status = TrialMobStatus.new
        mob_status.trial_battle_turn_id = battle_turn.id
        mob_status.trial_mob_id = mob.trial_mob_id
        mob_status.start_hp = mob.hp
        mob_status.start_sp = mob.sp
        mob_status.save
      end

      sorted_by_dex_mobs = Tools.sort_by_dex(atk_squad.mobs + def_squad.mobs)
      sorted_by_dex_mobs.each do |mob|
        next if mob.dead? or mob.retreated_from_battle?
        if atk_squad.annihilated?
          p 'atk_squad(' + atk_squad.name + ') was annihilated.'
          battle_turn.log += I18n.t('activerecord.battle_logs.battle_turn_end_annihilated', :name => atk_squad.name)
          battle_turn.save
          battle_ended_flg = true
          break
        elsif atk_squad.retreated_from_battle?
          p 'atk_squad(' + atk_squad.name + ') was retreated from battle.'
          battle_turn.log += I18n.t('activerecord.battle_logs.battle_turn_end_retreated', :name => atk_squad.name)
          battle_turn.save
          battle_ended_flg = true
          break
        elsif def_squad.annihilated?
          p 'def_squad(' + def_squad.name + ') was annihilated.'
          battle_turn.log += I18n.t('activerecord.battle_logs.battle_turn_end_annihilated', :name => def_squad.name)
          battle_turn.save
          battle_ended_flg = true
          break
        elsif def_squad.retreated_from_battle?
          p 'def_squad(' + def_squad.name + ') was retreated from battle.'
          battle_turn.log += I18n.t('activerecord.battle_logs.battle_turn_end_retreated', :name => def_squad.name)
          battle_turn.save
          battle_ended_flg = true
          break
        end

        # DoT / HoT execution phase
        unless mob.battle_effect_invs.blank?
          mob.battle_effect_invs.each do |effect|
            next if effect.remaining_duration == 0
            effect.remaining_duration -= 1
            if effect.method.type_symbol == :dot.to_s
              damage = calc_damage(effect.method.damage, effect.caused_mob.int, mob.skill_def)
              mob.hp -= damage
              mob.hp = 0 if mob.hp < 0
              effect.caused_mob.add_skill_exp(effect.method, damage)
              effect.caused_mob.hate += damage
              p mob.name + ' was damaged by ' + damage.to_s + ' from ' + effect.method.name + ', current hp is ' + mob.hp.to_s
              battle_turn.log += I18n.t('activerecord.battle_logs.dot_log', :name1 => mob.name, :name2 => effect.method.name, :damage => damage) + "\n"
              if mob.dead?
                battle_turn.log += I18n.t('activerecord.battle_logs.target_dead', :name1 => mob.name) + "\n"
                break
              end
            elsif effect.method.type_symbol == :hot.to_s
              heal = calc_damage(effect.method.heal, BASE_MOD, BASE_MOD)
              mob.hp += heal
              mob.hp = mob.max_hp if mob.max_hp < mob.hp
              effect.caused_mob.add_skill_exp(effect.method, heal)
              effect.caused_mob.hate += heal
              p mob.name + ' was healed by ' + heal.to_s + ' from ' + effect.method.name +  ', current hp is ' + mob.hp.to_s
              battle_turn.log += I18n.t('activerecord.battle_logs.hot_log', :name1 => mob.name, :name2 => effect.method.name, :heal => heal) + "\n"
            end
          end
        end
        next if mob.dead?

        # Battle phase
        battle_method = mob.battle_action
        next if battle_method.blank?

        # Battle range > 2 means remote attack range.
        if distance > 1
          # Ranged attack
          if battle_method.battle_type == :weapon and battle_method.method.range > 2
            phys_attack(battle_turn, mob)
          end
        else
          # Vertical move
          print mob.name_with_job_and_squad + ' pre-move:' + mob.vpos.to_s
          mob.vpos_move
          print ' post-move:' + mob.vpos.to_s + "\n"

          if battle_method.battle_type == :weapon
            phys_attack(battle_turn, mob)
          else
            if battle_method.method.type_symbol == :dd.to_s or battle_method.method.type_symbol == :dot.to_s
              skill_attack(battle_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :debuff.to_s
              skill_debuff(battle_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :hd.to_s or battle_method.method.type_symbol == :hot.to_s
              skill_heal(battle_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :buff.to_s
              skill_buff(battle_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :other.to_s
              skill_other(battle_turn, mob, battle_method.method)
            end
          end
        end
      end

      battle_turn.save

      (atk_squad.mobs + def_squad.mobs).each do |mob|
        mob_status = TrialMobStatus.where("trial_battle_turn_id = ? and trial_mob_id = ?", battle_turn.id, mob.trial_mob_id).first
        next if mob_status.nil?
        mob_status.vpos = mob.vpos
        mob_status.end_hp = mob.hp
        mob_status.end_sp = mob.sp
        mob_status.save
      end

      battle_ended_flg = true if distance > 1
      loop_index += 1
      battle_ended_flg = true if loop_index > 100
    end
  end

  private

  def self.phys_attack(battle_turn, mob)
    target_mobs = mob.target_enemy_mobs(mob.weapon.range, mob.weapon.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.name_with_job_and_squad + ':phys_attack to ' + target_mob.name
      if hit?(mob.weapon.hit_accuracy, mob.dex, target_mob.dex)
        damage = calc_damage(mob.weapon.damage, mob.str, target_mob.phys_def)
        target_mob.hp -= damage
        target_mob.hp = 0 if target_mob.hp < 0
        mob.add_weapon_exp(damage)
        mob.hate += damage
        p 'target_mob hp was damaged by ' + damage.to_s + ", current hp is " + target_mob.hp.to_s
        battle_turn.log += I18n.t('activerecord.battle_logs.atk_hit_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => mob.weapon.name, :damage => damage) + "\n"
        battle_turn.log += I18n.t('activerecord.battle_logs.target_dead', :name1 => target_mob.name) + "\n" if target_mob.dead?
      else
        battle_turn.log += I18n.t('activerecord.battle_logs.atk_miss_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => mob.weapon.name) + "\n"
      end
    end
  end

  def self.skill_attack(battle_turn, mob, skill)
    target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.name_with_job_and_squad + ':skill_attack to ' + target_mob.name
      if hit?(skill.hit_accuracy, mob.wis, target_mob.wis)
        damage = calc_damage(skill.damage, mob.int, target_mob.skill_def)
        target_mob.hp -= damage
        target_mob.hp = 0 if target_mob.hp < 0
        mob.sp -= skill.sp_cost
        mob.sp = 0 if mob.sp < 0
        mob.add_skill_exp(skill, damage)
        mob.hate += damage
        p 'target_mob hp was damaged by ' + damage.to_s + ', current hp is ' + target_mob.hp.to_s
        battle_turn.log += I18n.t('activerecord.battle_logs.atk_hit_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => skill.name, :damage => damage) + "\n"
        if target_mob.dead?
          battle_turn.log += I18n.t('activerecord.battle_logs.target_dead', :name1 => target_mob.name) + "\n"
        elsif skill.duration > 0
          # Add DoT Effect
          target_mob.add_effect(mob, skill)
        end
      else
        battle_turn.log += I18n.t('activerecord.battle_logs.atk_miss_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => mob.weapon.name) + "\n"
      end
    end
  end

  def self.skill_debuff(battle_turn, mob, skill)
    target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      if hit?(skill.hit_accuracy, mob.wis, target_mob.wis)
        target_mob.add_effect(mob, skill)
        mob.sp -= skill.sp_cost
        mob.sp = 0 if mob.sp < 0
        mob.add_skill_exp(skill, Params::BUFF_EXP)
        # p 'target_mob was debuffed'
        battle_turn.log += I18n.t('activerecord.battle_logs.buff_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => skill.name) + "\n"
      end
    end
  end

  def self.skill_heal(battle_turn, mob, skill)
    target_mobs = mob.target_damaged_friend_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.name_with_job_and_squad + ':skill_heal to ' + target_mob.name
      if hit?(skill.hit_accuracy, BASE_MOD, BASE_MOD)
        heal = calc_damage(skill.heal, BASE_MOD, BASE_MOD)
        target_mob.hp += heal
        target_mob.hp = target_mob.max_hp if target_mob.max_hp < target_mob.hp
        mob.sp -= skill.sp_cost
        mob.sp = 0 if mob.sp < 0
        mob.add_skill_exp(skill, heal)
        mob.hate += heal
        p 'target_mob hp was healed by ' + heal.to_s + ', current hp is ' + target_mob.hp.to_s
        battle_turn.log += I18n.t('activerecord.battle_logs.heal_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => skill.name, :heal => heal) + "\n"

        # Add HoT Effect
        if skill.duration > 0
          target_mob.add_effect(mob, skill)
        end
      end
    end
  end

  def self.skill_buff(battle_turn, mob, skill)
    target_mobs = mob.target_random_friend_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      if hit?(skill.hit_accuracy, BASE_MOD, BASE_MOD)
        mob.add_effect(mob, skill)
        mob.sp -= skill.sp_cost
        mob.sp = 0 if mob.sp < 0
        mob.add_skill_exp(skill, Params::BUFF_EXP)
        # p 'target_mob was buffed'
        battle_turn.log += I18n.t('activerecord.battle_logs.buff_log', :name1 => mob.name, :name2 => target_mob.name, :name3 => skill.name) + "\n"
      end
    end
  end

  def self.skill_other(battle_turn, mob, skill)
    case mob.job_id
      when Params::JOBS[:war]
        target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
        target_mobs.each do |target_mob|
          target_mob.hate += Params::TAUNT_HATE_INCREASE
          mob.sp -= skill.sp_cost
          mob.sp = 0 if mob.sp < 0
          mob.add_skill_exp(skill, Params::BUFF_EXP)
          # p "target_mob was taunted."
          battle_turn.log += I18n.t('activerecord.battle_logs.other_log', :name1 => mob.name, :name2 => skill.name) + "\n"
        end
      when Params::JOBS[:thf]
        return if Params::EVAC_HP_RATE < mob.squad.damaged_hp_rate
        squad.mobs each do |mob|
          mob.retreat_from_battle
        end
        p mob.squad.name + 'target_mob was evacuated.'
        squad.retreated_from_fortress = true
    end
  end

  def self.hit?(hit_accuracy, mod, target_mod)
    # p "hit_target_mod:" + target_mod.to_s + "," + "hit_mod:" + mod.to_s
    hit_adjust = Params::HIT_ADJUST_MAX * (target_mod - mod) / mod
    hit_adjust = Tools.filter_in_range(Params::HIT_ADJUST_MAX, hit_adjust)
    hit_rate = Tools.filter_in_percentage(hit_accuracy - (hit_accuracy * hit_adjust))
    # p "hit_adjust:" + hit_adjust.to_s + "," + "hit_rate:" + hit_rate.to_s
    return rand(Params::PERCENT_DENOMINATOR ** 2) <= hit_rate.round(2) * Params::PERCENT_DENOMINATOR
  end

  def self.calc_damage(damage, mod, target_mod)
    # p "damage_target_mod:" + target_mod.to_s + "," + "damage_mod:" + mod.to_s
    damage_adjust = Params::DAMAGE_ADJUST_MAX * target_mod / (damage + mod)
    damage_adjust = Tools.filter_in_range(Params::DAMAGE_ADJUST_MAX, damage_adjust)
    damage_rate = (damage + mod) * (1 - damage_adjust)
    calced_damage = Tools.gaussian_rand(damage_rate, damage_rate * Params::DAMAGE_SD).round
    calced_damage = 1 if calced_damage == 0
    # p "damage_adjust:" + damage_adjust.to_s  + "," + "damage:" + calced_damage.to_s
    return calced_damage
  end
end