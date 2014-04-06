# This class describes a cell of mini map.
class MiniMapCell < ActiveRecord::Base
  belongs_to :mini_map
  belongs_to :terrain
  belongs_to :sp_resource
  belongs_to :construction

  validates :mini_map_id, :presence => true
  validates :x, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :y, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :built_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000}
  validate :more_than_map_size
  validate :not_allowed_terrain

  # Validate x and y are not more than mini_map.size.
  def more_than_map_size
    return if mini_map_id.blank?
    mini_map = MiniMap.find(mini_map_id)
    return if mini_map.blank?

    if x + 1 > mini_map.size
      errors.add(:x, I18n.t('activerecord.errors.models.mini_map_cell.attributes.more_than_map_size'))
    elsif y + 1 > mini_map.size
      errors.add(:y, I18n.t('activerecord.errors.models.mini_map_cell.attributes.more_than_map_size'))
    end
  end

  # Validate sp_resource and construction are allowed on located terrain.
  def not_allowed_terrain
    return if terrain_id.blank?

    if not sp_resource_id.blank?
      sp_resource = SpResource.find(sp_resource_id)
      if not sp_resource.blank? and sp_resource.terrain_id != terrain_id
        errors.add(:sp_resource, I18n.t('activerecord.errors.models.mini_map_cell.attributes.not_allowed_terrain'))
      end
    end

    if not construction_id.blank?
      construction = Construction.find(construction_id)
      if not construction.blank? and construction.terrain_id != terrain_id
        errors.add(:construction, I18n.t('activerecord.errors.models.mini_map_cell.attributes.not_allowed_terrain'))
      end
    end
  end

  # Return construction.rq_prod_point.
  # This function is provided to keep same interface among mini_map_cell, mini_map_road and item. 
  # @return [Integer]
  def rq_prod_point
    return construction.rq_prod_point
  end
end
