class RouteRetriever
  def self.execute(trial, current_point, destination_point)
    manhattan_distance = (destination_point.x - current_point.x).abs + (destination_point.y - current_point.y).abs
    # p "Manhattan distance is " + manhattan_distance.to_s

    not_visited_points = Array.new
    trial.guard_mission.mini_map.fortress_cells.each do |cell|
      if cell.symbol == :concrete.to_s and not current_point.equal?(cell)
        not_visited_points << Point.new(cell.x, cell.y)
      end
    end

    searching_path_queue = [[current_point]]

    while not searching_path_queue.blank?
      retrieving_path = searching_path_queue.pop

      Point.identities.shuffle.each do |identity|
        retrieving_point = identity.add(retrieving_path.last)
        not_visited_points.each do |point|
          if retrieving_point.equal?(point) and not retrieving_path.include?(point)
            new_retrieving_path = Marshal.load(Marshal.dump(retrieving_path))
            new_retrieving_path << point
            not_visited_points.delete(point)
            searching_path_queue << new_retrieving_path
            if destination_point.equal?(point)
              return new_retrieving_path
            end
          end
        end
      end

      # p "not_visited_points.size:" + not_visited_points.size.to_s
      # p "searching_path_queue.size:" + searching_path_queue.size.to_s
    end
  end
end