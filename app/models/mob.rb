class Mob < ActiveRecord::Base
  belongs_to :houdd_user
  belongs_to :specie
  belongs_to :job
  belongs_to :squad

  has_many :dnas
  has_many :specie_job_invs

  # Return true if this mob is female.
  # @return [Boolean]
  def female?
    return true if gender_sym.to_sym == Params::GENDER_FEMALE
    return false
  end
end
