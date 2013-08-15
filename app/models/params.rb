class Params
  PERCENT_DENOMINATOR = 100
  DIRECTION_SYMBOLS = [:north, :east, :west, :south]
  MAP_DISTANCE_MAX = 100
  RESEARCH_SYMBOLS = [:wepon, :armor, :potion, :trap]
  PRODUCTION_QUE_DEFAULT_PRIORITY = 3
  PRODUCTION_QUE_DEFAULT_ALLOTMENT = 0
  NEW_ROOT_FIND_PERCENTAGE = 30
  








  DUNGEON_BLANK_SYMBOL = '0'
  DUNGEON_COCRETE_SYMBOL = '1'
  GENE_VARIANCE = 0.1
  GENE_MISSPRINT = 0.01
  MOB_ADULT_RATE = 0.1875
  ITEM_ARMOR_SYMBOLS = ['HELM', 'B-ARMOR', 'L-ARMOR']
  ITEM_WEPON_SYMBOLS = ['SWORD', 'BOW']
  ITEM_XRANGE_SYMBOLS = ['BOW']
  ITEM_TRAP_SYMBOL = 'TRAP'
  MISSION_ATK_SYMBOL = 'ATTACK'
  MISSION_DEF_SYMBOL = 'DEFENCE'
  WIZARD_JOB_IDS = [3]
  HEALER_JOB_IDS = [4]
  THIEF_JOB_IDS = [5]
  BATTLE_START_LINE = 1
  BATTLE_END_LINE = 5
  JOBS = {:war=>1, :rng=>2, :wiz=>3, :pri=>4, :thf=>5, :dra_slg=>6, :dra_ryl=>7}
  JOB_SKILLS = Array.new(JOBS.size + 1)
  JOB_SKILLS[JOBS[:war]] = {:knowledge=>1, :taunt=>2, :shield=>3}
  JOB_SKILLS[JOBS[:wiz]] = {:knowledge=>4, :fireball=>5, :waterjet=>6, :meteorstorm=>5}
  JOB_SKILLS[JOBS[:pri]] = {:knowledge=>8, :heal=>9, :regene=>10, :rain=>11}
  JOB_SKILLS[JOBS[:thf]] = {:knowledge=>12, :trap_disarm=>13, :search_treasure=>14, :evac=>15}
  JOB_SKILLS[JOBS[:rng]] = {:knowledge=>16, :doubleshot=>17, :snare=>18}
  JOB_SKILLS[JOBS[:dra_slg]] = {:breath=>19}
  JOB_SKILLS[JOBS[:dra_ryl]] = {:deepbreath=>20, :lavabreath=>21}
  SS_DEX_MAX = 10000
  TAUNT_HATE_INCREASE = 1000
  HIT_ADJUST_MAX = 0.3
  DAMAGE_AMPLIFIER = 0.2
  DAMAGE_ADJUST_MAX = 0.8
  DAMAGE_SD = 0.2
  X_ATK_TO_FORWARD_RATE = 80
  X_ATK_STACK_PENALTY_SIZE = 3
  X_ATK_STACK_PENALTY_RATE = 5
  X_ATK_DISTANCE_PENALTY_RATE = -5
  BATTLE_RATE_DENOMINATOR = 10000
  TRAP_DISARM_JOB_EXP = 30
  NATURAL_DEATH_SD = 0.4
  REVIVE_RATE = 50
  SHEILD_STATUS_MOD_IDS = [6]
end