class ProductionQue < ActiveRecord::Base
  belongs_to :houdd_user

  validates :allotment, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  # Return the description of item.
  # It could be 'road' and 'construction name(minimap name : x, y)'.
  # @return [String]
  def item_txt
    if symbol.to_sym == :mini_map_road
      return I18n.t('activerecord.attributes.production_que.mini_map_road')
    elsif symbol.to_sym == :mini_map_cell
      mini_map_cell = MiniMapCell.find(que_id)
      mini_map_cell_txt = "(" + mini_map_cell.mini_map.name + 
        ":" + mini_map_cell.x.to_s + "," + mini_map_cell.y.to_s + ")"
      return mini_map_cell.construction.name + mini_map_cell_txt
    else
      return nil
    end
  end

  # Return the description of status.
  # It could be 'destroying' and 'constructing'.
  # @return [String]
  def status_txt
    if destroy_flg
      return I18n.t('activerecord.attributes.production_que.destroy')
    else
      return I18n.t('activerecord.attributes.production_que.construct')
    end
  end
end
