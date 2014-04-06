class RouteRetriever
  def self.execute(trial, current_point, destination_point)
    manhattan_distance = (destination_point.x - current_point.x).abs + (destination_point.y - current_point.y).abs
    p "Manhattan distance is " + manhattan_distance.to_s

    fortress_cells = trial.guard_mission.mini_map.fortress_cells
    # searching_point = Marshal.load(Marshal.dump(current_point))
    # searching_path = Array.new
    # searching_paths = Array.new

    start_path = Array.new
    start_path << fortress_cells.find_by_x_and_y(current_point.x, current_point.y)
    searching_path_queue = Array.new
    searching_path_queue << start_path
    arraived_paths = Array.new

    # manhattan_distance.times do
    #   destination_point.sub_identities(searching_point).shuffle.each do |identity|
    # end


    index = 0
    while not searching_path_queue.blank?
      p "index:" + index.to_s
      retrieving_path = searching_path_queue.pop
      # print "(" + searching_cell.x.to_s + "," + searching_cell.y.to_s + ") -> "
      # break if destination_point.equal?(searching_cell)

      Point.identities.shuffle.each do |identity|
        connected_cell = fortress_cells.find_by_x_and_y_and_symbol(retrieving_path.last.x + identity.x, retrieving_path.last.y + identity.y, :concrete.to_s)


        if not connected_cell.blank? and not retrieving_path.include?(connected_cell)
          #p connected_cell.x.to_s + "," + connected_cell.y.to_s
          new_retrieving_path = Marshal.load(Marshal.dump(retrieving_path))
          new_retrieving_path << connected_cell
          searching_path_queue << new_retrieving_path
          if destination_point.equal?(connected_cell)
            arraived_paths << new_retrieving_path
          end
        end
      end
      # p searching_path_queue
      p "searching_path_queue.size:" + searching_path_queue.size.to_s
      p "arraived_paths.size:" + arraived_paths.size.to_s


      index += 1
      break if index > 500
    end

    arraived_paths.each do |arraived_path|
      arraived_path.each do |point|
        print "(" + point.x.to_s + "," + point.y.to_s + ") -> "
        p "end"
      end
    end




  end
end