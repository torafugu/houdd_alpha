# This class describes an item.
class Item < ActiveRecord::Base
  belongs_to :item_info
  belongs_to :houdd_user
  belongs_to :mob

  validates :item_info_id, :presence => true
  validates :houdd_user_id, :presence => true
  validates :dp, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000, :allow_blank => true}
  validates :quality, :numericality => {:only_integer => true, :greater_than_or_equal_to => -10, :less_than_or_equal_to => 10, :allow_blank => true}
  validates :built_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000, :allow_blank => true}

  # Return the name of item.
  # @return [String]
  def name
    return item_info.name + quality_txt
  end

  # Return the quality text of item.
  # '+' or '-' is added before the quality value.
  # @return [String]
  def quality_txt
    return '' if quality.blank?
    quality_txt = quality.to_s
    if quality < 0
      return quality_txt
    else
      return '+' + quality_txt
    end
  end

  # Return item_info.rq_prod_point.
  # This function is provided to keep same interface among mini_map_cell, mini_map_road and item. 
  # @return [Integer]
  def rq_prod_point
    return item_info.rq_prod_point
  end

  # Return the status of item.
  # @return [String]
  def status
    return I18n.t('activerecord.attributes.item.building') if rq_prod_point > built_point
    if mob.blank?
      return I18n.t('activerecord.attributes.item.not_equiped')
    else
      return mob.name + I18n.t('activerecord.attributes.item.equiping')
    end
  end

  # Execute missing method.
  # @note This method is used for calling ItemInfo method without specifying class name.
  def method_missing(action, *args)
    eval("item_info." + action.to_s)
  end

  before_save :set_default_values

  private

  def set_default_values
    self.dp = 0 if self.dp.blank?
    self.quality = Tools.gaussian_rand.truncate if self.quality.blank?
    self.built_point = 0 if self.built_point.blank?
  end
end
