class ProductionQue < ActiveRecord::Base
  belongs_to :houdd_user

  validates :priority, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :allow_blank => true}
  validates :allotment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true}

  # Return the description of que item.
  # It could be 'road' and 'construction name(minimap name : x, y)'.
  # @return [String]
  def item_txt
    if symbol.to_sym == :mini_map_road
      mini_map_road_txt = I18n.t('activerecord.attributes.production_que.mini_map_road')
      mini_map_road_txt += "(" + que_item.start_mini_map.name + "..." + que_item.end_mini_map.name + ")"
      return mini_map_road_txt
    elsif symbol.to_sym == :mini_map_cell
      mini_map_cell_txt = "(" + que_item.mini_map.name + 
        ":" + que_item.x.to_s + "," + que_item.y.to_s + ")"
      return que_item.construction.name + mini_map_cell_txt
    elsif symbol.to_sym == :item
      return que_item.item_info.name
    else
      return nil
    end
  end

  # Return the complete date of que item.
  # @return [String]
  def complete_date_txt
    return nil if allotment == 0
    complete_date = ((que_item.rq_prod_point - que_item.built_point) / allotment).ceil
    complete_date = (complete_date / Params::PRODUCTION_QUE_DESTORY_MULTIPLIER).ceil if destroy_flg
    return complete_date.to_s + I18n.t('activerecord.attributes.rq_days_suffix')
  end

  # Return the description of status.
  # It could be 'destroying' and 'constructing'.
  # @return [String]
  def status_txt
    if destroy_flg
      return I18n.t('activerecord.attributes.production_que.destroy')
    else
      if symbol.to_sym == :item
        return I18n.t('activerecord.attributes.production_que.manufacture')
      else
        return I18n.t('activerecord.attributes.production_que.construct')
      end
    end
  end

  # Return the que_item.
  # @return [que_item] que_item could be mini_map_road, mini_map_cell or item.
  def que_item
    case symbol.to_sym
    when :mini_map_road
      return MiniMapRoad.find_by_id(que_id)
    when :mini_map_cell
      return MiniMapCell.find_by_id(que_id)
    when :item
      return Item.find_by_id(que_id)
    else
      return nil
    end
  end

  # Destroy the que_item.
  # @return [Boolean] destroy result.
  def destroy_que_item
    case symbol.to_sym
    when :mini_map_road
      return MiniMapRoad.destroy(que_id)
    when :mini_map_cell
      mini_map_cell = MiniMapCell.find_by_id(que_id)
      mini_map_cell.construction_id = nil
      mini_map_cell.built_point = 0
      mini_map_cell.active_flg = false
      return mini_map_cell.save
    when :item
      return Item.destroy(que_id)
    else
      return false
    end
  end

  before_save :set_default_values
  before_destroy :deactivate_que_item

  private

  def set_default_values
    self.priority = Params::PRODUCTION_QUE_DEFAULT_PRIORITY if self.priority.blank?
    self.allotment = Params::PRODUCTION_QUE_DEFAULT_ALLOTMENT if self.allotment.blank?
  end

  def deactivate_que_item
    to_delete_que_item = que_item
    unless to_delete_que_item.nil?
      to_delete_que_item.active_flg = false
      to_delete_que_item.save
    end
  end
end
