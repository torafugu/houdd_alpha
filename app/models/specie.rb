class Specie < ActiveRecord::Base
  belongs_to :family

  has_many :mobs
  has_many :specie_job_invs

  # Return the number of mobs belong to this specie.
  # @return [Integer]
  def mobs_num
    return 0 if mobs.blank?
    return mobs.length
  end

  # Return the number of male mobs belong to this specie.
  # @return [Integer]
  def mobs_male_num
    mobs_male_num = 0
    mobs.each do |mob|
      mobs_male_num += 1 if not mob.female?
    end
    return mobs_male_num
  end

  # Return the number of female mobs belong to this specie.
  # @return [Integer]
  def mobs_female_num
    mobs_female_num = 0
    mobs.each do |mob|
      mobs_female_num += 1 if mob.female?
    end
    return mobs_female_num
  end
end
