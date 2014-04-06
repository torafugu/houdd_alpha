# This class is updater of ProductionQueue.
class ProductionQueueUpdater

  # Proceed updating and deleting of production queues.
  def self.execute(times)
    to_delete_production_queue_ids = Array.new

    # 1. Update ProductionQueue
    ProductionQueue.all.each do |production_queue|
      queue_item = production_queue.queue_item

      if production_queue.destroy_flg
        queue_item.built_point -= production_queue.allotment * times
        queue_item.built_point = 0 if queue_item.built_point < 0
        if queue_item.built_point == 0
          production_queue.destroy_queue_item
          to_delete_production_queue_ids << production_queue.id
        end
      else
        queue_item.built_point += production_queue.allotment * times
        queue_item.built_point = queue_item.rq_prod_point if queue_item.rq_prod_point < queue_item.built_point
        if queue_item.rq_prod_point == queue_item.built_point
          queue_item.active_flg = true
          to_delete_production_queue_ids << production_queue.id
        end
      end
      queue_item.save
      p queue_item
      production_queue.save
    end

    # 2. Delete ProductionQueue
    to_delete_production_queue_ids.each do |to_delete_production_queue_id|
      ProductionQueue.destroy(to_delete_production_queue_id)
    end
  end
end