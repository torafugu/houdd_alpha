# This class describes an user of Houdd.
class HouddUser < ActiveRecord::Base
  has_many :mini_maps
  has_many :researches
  has_many :production_queues
  has_many :mobs
  has_many :squads
  has_many :missions
  has_many :mission_strategies

  validates :name, :presence => true
  validates :login_id, format: { with: /\A[a-zA-Z1-9]+\z/ }
  validates :login_pw, format: { with: /\A[a-zA-Z1-9]+\z/ }
  validates :allot_for_item, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :allot_for_const, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :allot_for_research, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validate :allotment_is_not_100

  # Validate the total number of allot_for_item, allot_for_const and allot_for_research is 100%.
  def allotment_is_not_100
    if not allot_for_item.blank? and not allot_for_const.blank? and not allot_for_research.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.houdd_user.attributes.allotment_is_not_100')) if (allot_for_item + allot_for_const + allot_for_research) != 100
    end
  end

  # Return species which belong to user.
  # @return [Array<Specie>]
  def species
    species = Array.new

    mobs.each do |mob|
      species << mob.specie
    end

    return species.uniq
  end

  # Return sexual species which belong to user.
  # 'Sexual specie' means speice can create new mob by mating.
  # @return [Array<Specie>]
  def sexual_species
    species = Array.new

    mobs.each do |mob|
      species << mob.specie if not mob.asexual?
    end

    return species.uniq
  end

  # Return asexual species which belong to user.
  # 'Asexual specie' means speice can create new mob by splitting.
  # @return [Array<Specie>]
  def asexual_species
    species = Array.new

    mobs.each do |mob|
      species << mob.specie if mob.asexual?
    end

    return species.uniq
  end

  # Return the total number of foods in mini_maps.
  # @return [Integer]
  def foods_total
    foods_total = 0
    mini_maps.each do |map|
      foods_total += map.foods_total
    end
    return foods_total
  end

  # Return the total number of productions in mini_maps.
  # @return [Integer]
  def productions_total
    productions_total = 0
    mini_maps.each do |map|
      productions_total += map.productions_total
    end
    return productions_total
  end

  # Return the allotment total of production_queues.
  # @return [Integer]
  def allotment_total_of_production_queue
    allotment_total = 0
    production_queues.each do |production_queue|
      allotment_total += production_queue.allotment unless production_queue.allotment.blank?
    end
    return allotment_total
  end

  # Return the allotment total of researches.
  # @return [Integer]
  def allotment_total_of_research
    allotment_total = 0
    researches.each do |research|
      allotment_total += research.allotment unless research.allotment.blank?
    end
    return allotment_total
  end

  # Return the total number of remaining productions.
  # @return [Integer]
  def remaining_production_total
    return productions_total - allotment_total_of_production_queue - allotment_total_of_research
  end

  # Return the total number of moneys in mini_maps.
  # @return [Integer]
  def moneys_total
    moneys_total = 0
    mini_maps.each do |map|
      moneys_total += map.moneys_total
    end
    return moneys_total
  end

  # Return all the sp_resources in mini_maps.
  # @return [Array] array of sp_resource
  def sp_resources_all
    sp_resource_all = Array.new
    mini_maps.each do |map|
      sp_resource_all << map.sp_resources_all unless map.sp_resources_all.blank?
    end
    return sp_resource_all.uniq
  end

  # Return true or false by whether passed sp_resources are available or not.
  # @param [Array<Object>] sp_resources Array of sp_resource
  # @return [Boolean]
  def available_sp_resources?(sp_resources)
    return sp_resources_all.include?(sp_resources)
  end

  after_save :create_researches

  private

  def create_researches
    if researches.blank?
      Params::RESEARCH_SYMBOLS.each do |symbol|
        res = Research.new
        res.houdd_user_id = id
        res.symbol = symbol.to_s
        res.level = 1
        res.allotment = 0
        res.invested_point = 0
        res.save
        researches << res
      end
    end
  end
end
