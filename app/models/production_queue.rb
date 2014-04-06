# This class describes a production queue.
class ProductionQueue < ActiveRecord::Base
  belongs_to :houdd_user

  validates :priority, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :allow_blank => true}
  validates :allotment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true}

  # Return the description of que item.
  # It could be 'road' and 'construction name(minimap name : x, y)'.
  # @return [String]
  def item_txt
    if symbol.to_sym == :mini_map_road
      mini_map_road_txt = I18n.t('activerecord.attributes.production_que.mini_map_road')
      mini_map_road_txt += "(" + queue_item.start_mini_map.name + "..." + queue_item.end_mini_map.name + ")"
      return mini_map_road_txt
    elsif symbol.to_sym == :mini_map_cell
      mini_map_cell_txt = "(" + queue_item.mini_map.name + 
        ":" + queue_item.x.to_s + "," + queue_item.y.to_s + ")"
      return queue_item.construction.name + mini_map_cell_txt
    elsif symbol.to_sym == :item
      return queue_item.item_info.name
    else
      return nil
    end
  end

  # Return the complete date of que item.
  # @return [String]
  def complete_date_txt
    return nil if allotment.blank? or allotment == 0 or queue_item.rq_prod_point.blank? or queue_item.built_point.blank?
    complete_date = ((queue_item.rq_prod_point - queue_item.built_point) / allotment).ceil
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

  # Return the queue_item.
  # @return [queue_item] queue_item could be mini_map_road, mini_map_cell or item.
  def queue_item
    case symbol.to_sym
    when :mini_map_road
      return MiniMapRoad.find_by_id(queue_id)
    when :mini_map_cell
      return MiniMapCell.find_by_id(queue_id)
    when :item
      return Item.find_by_id(queue_id)
    else
      return nil
    end
  end

  # Destroy the queue_item.
  # @return [Boolean] destroy result.
  def destroy_queue_item
    case symbol.to_sym
    when :mini_map_road
      return MiniMapRoad.destroy(queue_id)
    when :mini_map_cell
      mini_map_cell = MiniMapCell.find_by_id(queue_id)
      mini_map_cell.construction_id = nil
      mini_map_cell.built_point = 0
      mini_map_cell.active_flg = false
      return mini_map_cell.save
    when :item
      return Item.destroy(queue_id)
    else
      return false
    end
  end

  before_save :set_default_values
  before_destroy :deactivate_queue_item

  private

  def set_default_values
    self.priority = Params::PRODUCTION_QUEUE_DEFAULT_PRIORITY if self.priority.blank?
    self.allotment = Params::PRODUCTION_QUEUE_DEFAULT_ALLOTMENT if self.allotment.blank?
  end

  def deactivate_queue_item
    if not queue_item.nil? and queue_item.rq_prod_point != queue_item.built_point
      queue_item.active_flg = false
      queue_item.save
    end
  end
end
