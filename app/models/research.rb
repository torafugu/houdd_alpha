class Research < ActiveRecord::Base
  belongs_to :houdd_user

  validates :symbol, format: { with: /\A[a-zA-Z]+\z/ }
  validates :level, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100}
  validates :allotment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :invested_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  # Return the description of research.
  # @return [String]
  def name
    return I18n.t('activerecord.attributes.research.' + symbol)
  end

  # Return the complete date of que item.
  # @return [String]
  def complete_date_txt
    return nil if allotment == 0
    rq_prod_point = (level + 1) * Params::RESEARCH_COST_BASE
    complete_date = ((rq_prod_point - invested_point) / allotment).ceil
    return complete_date.to_s + I18n.t('activerecord.attributes.rq_days_suffix')
  end
end
