# This class describes a job.
class Job < ActiveRecord::Base
  has_many :skills, :through => :job_skill_invs
  has_many :job_skill_invs, :dependent => :delete_all

  # Return the description of job type.
  # @return [String]
  def type_symbol_txt
    return I18n.t('activerecord.attributes.job.' + type_symbol)
  end
end
