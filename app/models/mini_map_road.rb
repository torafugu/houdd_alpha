class MiniMapRoad < ActiveRecord::Base
  belongs_to :start_mini_map, :class_name => 'MiniMap', :foreign_key => 'start_mini_map_id'
  belongs_to :end_mini_map, :class_name => 'MiniMap', :foreign_key => 'end_mini_map_id'

  validates :start_mini_map_id, :presence => true
  validates :end_mini_map_id, :presence => true
  validates :level, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5}
  validates :built_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000}
  validate :same_start_and_end

  # Validate start_mini_map_id and end_mini_map_id are different.
  def same_start_and_end
    if start_mini_map_id == end_mini_map_id
      errors.add(:base, I18n.t('activerecord.errors.models.mini_map_road.attributes.same_start_and_end'))
    end
  end

  # Return true or false by whether level up is already registered to production_que or not.
  # @return [Boolean]
  def is_constructing?
    constructing_que = ProductionQue.find_by_symbol_and_que_id_and_destroy_flg(:mini_map_road.to_s, id, false)
    return true unless constructing_que.blank?
    return false
  end

  # Return true or false by whether destroy is already registered to production_que or not.
  # @return [Boolean]
  def is_destroying?
    destroying_que = ProductionQue.find_by_symbol_and_que_id_and_destroy_flg(:mini_map_road.to_s, id, true)
    return true unless destroying_que.blank?
    return false
  end

  # Return the description of status.
  # It could be 'level_up', 'destroying', 'active' and 'disable'.
  # @return [String]
  def status_txt
    if is_constructing?
      return I18n.t('activerecord.attributes.mini_map_road.construct')
    elsif is_destroying?
      return I18n.t('activerecord.attributes.mini_map_road.destroy')
    elsif active_flg
      return I18n.t('activerecord.attributes.mini_map_road.active')
    else
      return I18n.t('activerecord.attributes.mini_map_road.disable')
    end
  end

  before_save :set_random_distance

  private

  def set_random_distance
    self.distance = rand(Params::MAP_DISTANCE_MAX) + 1 if self.distance.blank?
  end
end
