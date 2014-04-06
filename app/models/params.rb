# This class keeps all the global static constants.
class Params

  # Denominator of percentage.
  PERCENT_DENOMINATOR = 100

  # Maximum value of sum of squares.
  SS_MAX = 10000

  # Symbols of a point of the compass.
  DIRECTION_SYMBOLS = [:north, :east, :west, :south]

  # Base cost of research.
  RESEARCH_COST_BASE = 1000

  # Symbols of research.
  RESEARCH_SYMBOLS = [:wepon, :armor, :potion, :trap]

  # Maximum distance between mini maps.
  MAP_DISTANCE_MAX = 100

  # Base cost of building new road between mini maps.
  ROAD_BUILD_COST_BASE = 100

  # Multiplier of fortress size which calculated from mini map size.
  FORTRESS_SIZE_MULTIPLIER = 2

  # Description of item.(Internationalized)
  ITEM_SYMBOL_DESCRIPTIONS = Hash.new
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.wepon')] = :wepon.to_s
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.natural_wepon')] = :natural_wepon.to_s
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.armor')] = :armor.to_s
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.natural_armor')] = :natural_armor.to_s
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.potion')] = :potion.to_s
  ITEM_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.research.trap')] = :trap.to_s

  # Description of element.(Internationalized)
  ELEMRNT_SYMBOL_DESCRIPTIONS = Hash.new
  ELEMRNT_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.element.fire')] = :fire.to_s
  ELEMRNT_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.element.water')] = :water.to_s
  ELEMRNT_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.element.light')] = :light.to_s
  ELEMRNT_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.element.darkness')] = :darkness.to_s
  ELEMRNT_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.element.nothing')] = :nothing.to_s

  # Description of skill.(Internationalized)
  SKILL_TYPE_DESCRIPTIONS = Hash.new
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.dd')] = :dd.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.dot')] = :dot.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.hd')] = :hd.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.hot')] = :hot.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.buff')] = :buff.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.debuff')] = :debuff.to_s
  SKILL_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.skill.other')] = :other.to_s

  # Description of gender.(Internationalized)
  GENDER_SYMBOL_DESCRIPTIONS = Hash.new
  GENDER_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.gender.m')] = :m.to_s
  GENDER_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.gender.f')] = :f.to_s
  GENDER_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.gender.a')] = :a.to_s

  # Default priority of production queue item.
  PRODUCTION_QUEUE_DEFAULT_PRIORITY = 3

  # Default allotment of production queue item.
  PRODUCTION_QUEUE_DEFAULT_ALLOTMENT = 0

  # Multiplier of destroying production queue item.
  # @note Destroying is faster than creating.
  PRODUCTION_QUEUE_DESTORY_MULTIPLIER = 10

  # Ratio percentageof finding new root to another mini map.
  NEW_ROOT_FIND_PERCENTAGE = 30

  # Symbol of female gender.
  GENDER_FEMALE = :f

  # Symbol of male gender.
  GENDER_MALE = :m

  # Symbol of male asexual.
  GENDER_ASEXUAL = :a

  # Quantity of gene which belongs to same mob.
  MOB_DNA_QUANTITY = 2

  # Variance of gene attribute modifier for seed mob.
  GENE_SEED_VARIANCE = 0.1

  # Variance of gene attribute modifier for mating.
  GENE_MIX_VARIANCE = 0.1

  # Becoming an adult age rate with life of mob.
  MOB_ADULT_AGE_RATE = 0.1875

  # Maximum age of mob.
  MOB_AGE_MAX = 1000

  # Maximum status value of mob.
  MOB_STATUS_MAX = 100000

  # Maximum element value of mob.
  MOB_ELEMENT_MAX = 1000

  # Minimum element value of mob.
  MOB_ELEMENT_MIN = -1000

  # Multiplier of sp which is calculated from CON.
  MOB_MAX_HP_MULTIPLIER = 2

  # Multiplier of sp which is calculated from CON.
  MOB_MAX_SP_MULTIPLIER = 2

  # Description of job type.(Internationalized)
  JOB_TYPE_DESCRIPTIONS = Hash.new
  JOB_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.job.tank')] = :tank.to_s
  JOB_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.job.healer')] = :healer.to_s
  JOB_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.job.attacker_c')] = :attacker_c.to_s
  JOB_TYPE_DESCRIPTIONS[I18n.t('activerecord.attributes.job.attacker_r')] = :attacker_r.to_s

  # Symbols of mission category.
  MISSION_CATEGORY_SYMBOLS = [:guard, :intrude, :move]

  # Description of mission status.(Internationalized)
  MISSION_CATEGORY_SYMBOL_DESCRIPTIONS = Hash.new
  MISSION_CATEGORY_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.guard')] = :guard.to_s
  MISSION_CATEGORY_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.intrude')] = :intrude.to_s
  MISSION_CATEGORY_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.move')] = :move.to_s

  # Symbols of mission status.
  MISSION_STATUS_SYMBOLS = [:not_start, :on_going, :pending, :completed]

  # Description of mission status.(Internationalized)
  MISSION_STATUS_SYMBOL_DESCRIPTIONS = Hash.new
  MISSION_STATUS_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.not_start')] = :not_start.to_s
  MISSION_STATUS_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.on_going')] = :on_going.to_s
  MISSION_STATUS_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.pending')] = :pending.to_s
  MISSION_STATUS_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.completed')] = :completed.to_s
  MISSION_STATUS_SYMBOL_DESCRIPTIONS[I18n.t('activerecord.attributes.mission.cancel')] = :cancel.to_s

  # Multiplier of fortress size which calculated from mini map size.
  ENEMY_VISIBLE_DISTANCE = 4

  # Vpos of mobs of attacker squad
  BATTLE_START_ATK_VPOS = 1

  # Vpos of mobs of defender squad
  BATTLE_START_DEF_VPOS = 5

  # Maximum value of hit adjustment.
  HIT_ADJUST_MAX = 0.3

  # Maximum value of damage adjustment.
  DAMAGE_ADJUST_MAX = 0.8

  # Standard deviation of damage
  DAMAGE_SD = 0.2

  # Exp for Buff and DeBuff.
  BUFF_EXP = 5

  # Job IDs.
  JOBS = {:war=>1, :wiz=>2, :pri=>3, :thf=>4, :rng=>5}


  # ITEM_ARMOR_SYMBOLS = ['HELM', 'B-ARMOR', 'L-ARMOR']
  # ITEM_WEPON_SYMBOLS = ['SWORD', 'BOW']
  # ITEM_XRANGE_SYMBOLS = ['BOW']
  # ITEM_TRAP_SYMBOL = 'TRAP'
  # MISSION_ATK_SYMBOL = 'ATTACK'
  # MISSION_DEF_SYMBOL = 'DEFENCE'
  # WIZARD_JOB_IDS = [3]
  # HEALER_JOB_IDS = [4]
  # THIEF_JOB_IDS = [5]
  # BATTLE_START_LINE = 1
  # BATTLE_END_LINE = 5
  # JOBS = {:war=>1, :rng=>2, :wiz=>3, :pri=>4, :thf=>5, :dra_slg=>6, :dra_ryl=>7}
  # JOB_SKILLS = Array.new(JOBS.size + 1)
  # JOB_SKILLS[JOBS[:war]] = {:knowledge=>1, :taunt=>2, :shield=>3}
  # JOB_SKILLS[JOBS[:wiz]] = {:knowledge=>4, :fireball=>5, :waterjet=>6, :meteorstorm=>5}
  # JOB_SKILLS[JOBS[:pri]] = {:knowledge=>8, :heal=>9, :regene=>10, :rain=>11}
  # JOB_SKILLS[JOBS[:thf]] = {:knowledge=>12, :trap_disarm=>13, :search_treasure=>14, :evac=>15}
  # JOB_SKILLS[JOBS[:rng]] = {:knowledge=>16, :doubleshot=>17, :snare=>18}
  # JOB_SKILLS[JOBS[:dra_slg]] = {:breath=>19}
  # JOB_SKILLS[JOBS[:dra_ryl]] = {:deepbreath=>20, :lavabreath=>21}
  # TAUNT_HATE_INCREASE = 1000
  # DAMAGE_AMPLIFIER = 0.2
  # DAMAGE_ADJUST_MAX = 0.8
  # DAMAGE_SD = 0.2
  # X_ATK_TO_FORWARD_RATE = 80
  # X_ATK_STACK_PENALTY_SIZE = 3
  # X_ATK_STACK_PENALTY_RATE = 5
  # X_ATK_DISTANCE_PENALTY_RATE = -5
  # BATTLE_RATE_DENOMINATOR = 10000
  # TRAP_DISARM_JOB_EXP = 30
  # NATURAL_DEATH_SD = 0.4
  # REVIVE_RATE = 50
  # SHEILD_STATUS_MOD_IDS = [6]
end