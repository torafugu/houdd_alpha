# This class is updater of Battle in Trial.
class TrialBattleUpdater

  # Modifier value if no parameter is provided.
  BASE_MOD = 1

  def self.execute(move_turn, atk_squad, def_squad, distance)
    p "Battle of " + atk_squad.id.to_s + "," + def_squad.id.to_s + "," + distance.to_s

    # Set-up phase
    atk_squad.mobs.each do |mob|
      mob.enemy_mobs = def_squad.mobs
      mob.friend_mobs = atk_squad.mobs
      mob.divide_to_attacker
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
      mob.divide_to_defender
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
      sorted_by_dex_mobs = Tools.sort_by_dex(atk_squad.mobs + def_squad.mobs)
      sorted_by_dex_mobs.each do |mob|
        next if mob.dead? or mob.retreated_from_battle?
        # DoT / HoT execution phase

        # Battle phase
        if distance > 1
          # Ranged attack
        else
          # Vertical move
          print mob.attacker?.to_s + " " + mob.name_with_job + " pre-move:" + mob.vpos.to_s
          mob.vpos_move
          print  " post-move:" + mob.vpos.to_s + "\n"

          battle_method = mob.battle_action
          next if battle_method.blank?

          if battle_method.battle_type == :wepon
            phys_attack(move_turn, mob)
          else
            if battle_method.method.type_symbol == :dd.to_s or battle_method.method.type_symbol == :dot.to_s
              skill_attack(move_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :debuff.to_s
              skill_debuff(move_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :hd.to_s or battle_method.method.type_symbol == :hot.to_s
              skill_heal(move_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :buff.to_s
              skill_buff(move_turn, mob, battle_method.method)
            elsif battle_method.method.type_symbol == :other.to_s
              skill_other(move_turn, mob, battle_method.method)
            end
          end
        end

      end


      battle_ended_flg = true




    end


  end

  private

  def self.phys_attack(move_turn, mob)
    target_mobs = mob.target_enemy_mobs(mob.wepon.range, mob.wepon.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.attacker?.to_s + ":" + mob.name_with_job + ":phys_attack!:to " + target_mob.name
      if hit?(mob.wepon.hit_accuracy, mob.dex, target_mob.dex)
        damage = calc_damage(mob.wepon.damage, mob.str, target_mob.phys_def)
        target_mob.hp -= damage
        target_mob.hp = 0 if target_mob.hp < 0
        mob.add_wepon_exp(damage)
        mob.hate += damage
        p "target_mob hp was damaged by " + damage.to_s + ", current hp is " + target_mob.hp.to_s
        add_battle_log(move_turn, mob, target_mob, damage, mob.wepon.name)
      end
    end
  end

  def self.skill_attack(move_turn, mob, skill)
    target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.attacker?.to_s + ":" + mob.name_with_job + ":phys_attack!:to " + target_mob.name
      if hit?(skill.hit_accuracy, mob.wis, target_mob.wis)
        damage = calc_damage(skill.damage, mob.int, target_mob.skill_def)
        target_mob.hp -= damage
        target_mob.hp = 0 if target_mob.hp < 0
        mob.add_skill_exp(skill, damage)
        mob.hate += damage
        p "target_mob hp was damaged by " + damage.to_s + ", current hp is " + target_mob.hp.to_s
        add_battle_log(move_turn, mob, target_mob, damage, skill.name)
      end
    end
  end

  def self.skill_debuff(move_turn, mob, skill)
    target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      if hit?(skill.hit_accuracy, mob.wis, target_mob.wis)
        mob.add_effect(mob, skill)
        mob.add_skill_exp(skill, Params::BUFF_EXP)
        p "target_mob was debuffed"
        add_battle_log(move_turn, mob, target_mob, 0, skill.name)
      end
    end
  end

  def self.skill_heal(move_turn, mob, skill)
    target_mobs = mob.target_enemy_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      p mob.attacker?.to_s + ":" + mob.name_with_job + ":phys_attack!:to " + target_mob.name
      if hit?(skill.hit_accuracy, BASE_MOD, BASE_MOD)
        heal = calc_damage(skill.heal, BASE_MOD, BASE_MOD)
        target_mob.hp += heal
        target_mob.hp = 0 if target_mob.max_hp < target_mob.hp
        mob.add_skill_exp(skill, heal)
        mob.hate += heal
        p "target_mob hp was healed by " + heal.to_s + ", current hp is " + target_mob.hp.to_s
        add_battle_log(move_turn, mob, target_mob, heal, skill.name)
      end
    end
  end

  def self.skill_buff(move_turn, mob, skill)
    target_mobs = mob.target_random_friend_mobs(skill.range, skill.num_of_tgt)
    target_mobs.each do |target_mob|
      if hit?(skill.hit_accuracy, BASE_MOD, BASE_MOD)
        mob.add_effect(mob, skill)
        mob.add_skill_exp(skill, Params::BUFF_EXP)
        p "target_mob was buffed"
        add_battle_log(move_turn, mob, target_mob, 0, skill.name)
      end
    end
  end

  def self.skill_other(move_turn, mob, skill)
    case mob.job_id
    when Params::JOBS[:war]
      p "taunt!"
    when Params::JOBS[:thf]
      p "evac!"
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

  def self.add_battle_log(move_turn, mob, target_mob, damage, method_txt)
    battle_log = TrialBattleLog.new
    battle_log.trial_move_turn_id = move_turn.id
    battle_log.trial_mob_id = mob.trial_mob_id
    battle_log.vpos = mob.vpos
    battle_log.target_mob_id = target_mob.id
    battle_log.target_dead_flg = target_mob.dead?
    battle_log.damage = damage
    battle_log.method_txt = method_txt
    battle_log.save
    move_turn.trial_battle_logs << battle_log
  end

end