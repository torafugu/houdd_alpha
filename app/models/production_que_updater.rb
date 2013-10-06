class ProductionQueUpdater

  def self.execute
    to_delete_production_que_ids = Array.new

    # 1. Update ProductionQue
    ProductionQue.all.each do |production_que|
      que_item = production_que.que_item

      if production_que.destroy_flg
        que_item.built_point -= production_que.allotment
        que_item.built_point = 0 if que_item.built_point < 0
        if que_item.built_point == 0
          production_que.destroy_que_item
          to_delete_production_que_ids << production_que.id
        end
      else
        que_item.built_point += production_que.allotment
        que_item.built_point = que_item.rq_prod_point if que_item.rq_prod_point < que_item.built_point
        if que_item.rq_prod_point == que_item.built_point
          que_item.active_flg = true
          to_delete_production_que_ids << production_que.id
        end
      end
      que_item.save
      production_que.save
    end

    # 2. Delete ProductionQue
    to_delete_production_que_ids.each do |to_delete_production_que_id|
      ProductionQue.destroy(to_delete_production_que_id)
    end
  end
end