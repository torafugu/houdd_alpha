class Research < ActiveRecord::Base
  belongs_to :houdd_user

  validates :symbol, format: { with: /\A[a-zA-Z]+\z/ }
  validates :level, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100}
  validates :allotment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :invested_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
end
