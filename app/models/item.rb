class Item < ActiveRecord::Base
  belongs_to :item_info
  belongs_to :houdd_user

  validates :item_info_id, :presence => true
  validates :houdd_user_id, :presence => true
  validates :dp, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000, :allow_blank => true}
  validates :quality, :numericality => {:only_integer => true, :greater_than_or_equal_to => -10, :less_than_or_equal_to => 10, :allow_blank => true}
  validates :built_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000, :allow_blank => true}

  # Return item_info.rq_prod_point.
  # This function is provided to keep same interface among mini_map_cell, mini_map_road and item. 
  # @return [Integer]
  def rq_prod_point
    return item_info.rq_prod_point
  end

  before_save :set_default_values

  private

  def set_default_values
    self.dp = 0 if self.dp.blank?
    self.quality = Tools.gaussian_rand.truncate if self.quality.blank?
    self.built_point = 0 if self.built_point.blank?
  end
end
