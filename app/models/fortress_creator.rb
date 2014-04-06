# Factory class of Fortress.
class FortressCreator

  # Base room size percentage in area.
  ROOM_BASE_PERCENTAGE = 40

  # Additional room size percentage in area.
  ROOM_MAX_ADD_PERCENTAGE = 40

  # Minimum size of fortress.
  MINIMUM_SIZE = 9

  # Size coefficient of fortress size.
  # @note fortress_size = MINIMUM_SIZE + MiniMap.find(mini_map_id).size * SIZE_COEFFICIENT
  SIZE_COEFFICIENT = 2

  # Maximum number of entrance of fortress.
  ENTRANCE_MAX = 4

  # Minimum length of vertical pathway is created.
  UNEVEN_PATH_LENGTH = 4

  # Create random fortress cells.
  # @param [Integer] mini_map_id MiniMap.id
  def self.random_cell(mini_map_id)
    FortressCell.destroy_all(["mini_map_id = ?", mini_map_id])
    fortress_size = MiniMap.find(mini_map_id).size * Params::FORTRESS_SIZE_MULTIPLIER - 1
    fortress_x_cursor = 0
    cluster_side_num = (fortress_size / MINIMUM_SIZE).truncate
    cluster_side_length = (fortress_size / cluster_side_num).truncate
    modified_fortress_size = fortress_size - (fortress_size % cluster_side_num)
    fortress_cells = Array.new(modified_fortress_size).map!{ Array.new(modified_fortress_size, :blank) }
    areas = Array.new(cluster_side_num).map!{ Array.new(cluster_side_num, nil) }

    exit_directions = Params::DIRECTION_SYMBOLS.sample(rand(ENTRANCE_MAX) + 1)
    exit = Struct.new(:direction, :x, :y)
    exit_paths = Array.new
    exit_directions.each do |path|
      case path
      when :north
        exit_paths << exit.new(path, rand(cluster_side_num), 0)
      when :south
        exit_paths << exit.new(path, rand(cluster_side_num), cluster_side_num - 1)
      when :east
        exit_paths << exit.new(path, cluster_side_num - 1  , rand(cluster_side_num))
      when :west
        exit_paths << exit.new(path, 0               , rand(cluster_side_num))
      end
    end

    # create areas
    cluster_side_num.times do |y|
      cluster_side_num.times do |x|
        exit_direction = nil
        exit_paths.each do |exit_path|
          if exit_path[:x] == x and exit_path[:y] == y
            exit_direction = exit_path[:direction]
            break
          end
        end
        areas[x][y] = Area.new(x * cluster_side_length, y * cluster_side_length, cluster_side_length, exit_direction, fortress_cells)
      end
    end

    area_path_directions = [:east, :south]
    # create path between areas
    cluster_side_num.times do |y|
      cluster_side_num.times do |x|
        room_path_directions = Array.new
        # not east and south end 
        if x + 1 < cluster_side_num and y + 1 < cluster_side_num
          #room_path_directions = area_path_directions.sample(rand(area_path_directions.size) + 1)
          room_path_directions = area_path_directions.sample(area_path_directions.size)
        # east end and not south end 
        elsif x + 1 == cluster_side_num and y + 1 < cluster_side_num
          # if areas[x - 1][y].is_connected_east?
          #   room_path_directions = [:south].sample(rand([:south].size))
          # else
            room_path_directions = [:south]
          # end
        # not east end and south end 
        elsif x + 1 < cluster_side_num and y + 1 == cluster_side_num
          # if areas[x][y - 1].is_connected_south?
          #   room_path_directions = [:east].sample(rand([:east].size))
          # else
            room_path_directions = [:east]
          # end
        end

        room_path_directions.each do |room_path_direction|
          if room_path_direction == :east
            p "area(" + x.to_s + "," + y.to_s + "):east path"
            create_room_path(areas[x][y], areas[x + 1][y], :east, fortress_cells)
          elsif room_path_direction == :south
            p "area(" + x.to_s + "," + y.to_s + "):south path"
            create_room_path(areas[x][y], areas[x][y + 1], :south, fortress_cells)
          end
          areas[x][y].connected_directions << room_path_direction
        end
      end
    end

    # create fortress_cells
    modified_fortress_size.times do |y|
      modified_fortress_size.times do |x|
        fortress_cell = FortressCell.new
        fortress_cell.mini_map_id = mini_map_id
        fortress_cell.x = x
        fortress_cell.y = y
        fortress_cell.symbol = fortress_cells[x][y]
        fortress_cell.save
      end
    end
  end

  private

  def self.create_room_path(area1, area2, direction, cells)
    area_paths = Array.new
    if direction == :east
      #if (area2.room.y_center - area1.room.y_center).abs < UNEVEN_PATH_LENGTH
      if (area2.room.x1 - area1.room.x2 < UNEVEN_PATH_LENGTH) or ((not area1.is_enough_space_room_east?) or (not area2.is_enough_space_room_west?))
        area_path = Rectangle.new
        area_path.x1 = area1.room.x2
        area_path.x2 = area2.room.x1
        area_path.y1 = area1.room.y_center
        area_path.y2 = area1.room.y_center
        area_paths << area_path
      else
        area_path1 = Rectangle.new
        area_path1.x1 = area1.room.x2
        area_path1.x2 = area1.x2
        area_path1.y1 = area1.room.y_center
        area_path1.y2 = area1.room.y_center
        area_path2 = Rectangle.new
        area_path2.x1 = area1.x2
        area_path2.x2 = area1.x2
        area_path2.y1 = area1.room.y_center
        area_path2.y2 = area2.room.y_center
        area_path3 = Rectangle.new
        area_path3.x1 = area1.x2
        area_path3.x2 = area2.room.x1
        area_path3.y1 = area2.room.y_center
        area_path3.y2 = area2.room.y_center
        area_paths << area_path1
        area_paths << area_path2
        area_paths << area_path3
      end
    elsif direction == :south
      #if (area2.room.x_center - area1.room.x_center).abs < UNEVEN_PATH_LENGTH
      if (area2.room.y1 - area1.room.y2 < UNEVEN_PATH_LENGTH) or ((not area1.is_enough_space_room_south?) or (not area2.is_enough_space_room_north?))
        area_path = Rectangle.new
        area_path.x1 = area1.room.x_center
        area_path.x2 = area1.room.x_center
        area_path.y1 = area1.room.y2
        area_path.y2 = area2.room.y1
        area_paths << area_path
      else
        area_path1 = Rectangle.new
        area_path1.x1 = area1.room.x_center
        area_path1.x2 = area1.room.x_center
        area_path1.y1 = area1.room.y2
        area_path1.y2 = area1.y2
        area_path2 = Rectangle.new
        area_path2.x1 = area1.room.x_center
        area_path2.x2 = area2.room.x_center
        area_path2.y1 = area1.y2
        area_path2.y2 = area1.y2
        area_path3 = Rectangle.new
        area_path3.x1 = area2.room.x_center
        area_path3.x2 = area2.room.x_center
        area_path3.y1 = area1.y2
        area_path3.y2 = area2.room.y1
        area_paths << area_path1
        area_paths << area_path2
        area_paths << area_path3
      end
    end

    p area_paths

    area_paths.each do |area_path|
      path_x1 = area_path.x1
      path_x2 = area_path.x2
      if area_path.x1 > area_path.x2
        path_x1 = area_path.x2
        path_x2 = area_path.x1
      end
      path_y1 = area_path.y1
      path_y2 = area_path.y2
      if area_path.y1 > area_path.y2
        path_y1 = area_path.y2
        path_y2 = area_path.y1
      end

      for y in path_y1..path_y2 do
        for x in path_x1..path_x2 do
          cells[x][y] = :concrete
          p x.to_s + "," + y.to_s
        end
      end
    end
  end

  # This class describes sub-area of Fortress.
  # Area is connected to another area by pathway.
  class Area < Rectangle

    # Least length between room border and area border.
    NARROW_BETWEEN_ROOM_AND_AREA_SIZE = 1

    attr_accessor :x1, :x2, :y1, :y2, :room, :connected_directions

    # @param [Integer] x x-coordinate of top-left.
    # @param [Integer] y y-coordinate of top-left.
    # @param [Integer] size side size of Area
    # @param [Array] cells Array of FortressCell.
    def initialize(x, y, size, direction, cells)
      @x1 = x
      @y1 = y
      @x2 = x + size - 1
      @y2 = y + size - 1
      @area_size = size
      @room_size = random_room_size
      @room = Rectangle.new
      @room.x1 = @x1 + rand(@area_size - @room_size - 2).truncate + 1
      @room.y1 = @y1 + rand(@area_size - @room_size - 2).truncate + 1
      @room.x2 = @room.x1 + @room_size - 1
      @room.y2 = @room.y1 + @room_size - 1
      @exit_direction = direction
      @exit_path = nil
      @fortress_cells = cells
      set_exit_path
      update_cells
      @connected_directions = Array.new
    end

    # Return true or false whether east border of Area is connected to another Area or not.
    # @return [Boolean]
    def is_connected_east?
      return true if @connected_directions.include?(:east)
      return false
    end

    # Return true or false whether south border of Area is connected to another Area or not.
    # @return [Boolean]
    def is_connected_south?
      return true if @connected_directions.include?(:south)
      return false
    end

    # Return true or false whether there is larger space than NARROW_BETWEEN_ROOM_AND_AREA_SIZE between east border of Area and room or not.
    # @return [Boolean]
    def is_enough_space_room_east?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @x2 - @room.x2
      return false
    end

    # Return true or false whether there is larger space than NARROW_BETWEEN_ROOM_AND_AREA_SIZE between west border of Area and room or not.
    # @return [Boolean]
    def is_enough_space_room_west?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @room.x1 - @x1
      return false
    end

    # Return true or false whether there is larger space than NARROW_BETWEEN_ROOM_AND_AREA_SIZE between north border of Area and room or not.
    # @return [Boolean]
    def is_enough_space_room_north?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @room.y1 - @y1
      return false
    end

    # Return true or false whether there is larger space than NARROW_BETWEEN_ROOM_AND_AREA_SIZE between south border of Area and room or not.
    # @return [Boolean]
    def is_enough_space_room_south?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @y2 - @room.y2
      return false
    end 

    private

    def random_room_size
      return (@area_size * (rand(ROOM_MAX_ADD_PERCENTAGE) + ROOM_BASE_PERCENTAGE) / Params::PERCENT_DENOMINATOR).truncate
    end

    def set_exit_path
      p @exit_direction
      case @exit_direction
      when :north
        @exit_path = Rectangle.new
        @exit_path.x1 = @room.x_center
        @exit_path.y1 = @y1
        @exit_path.x2 = @room.x_center
        @exit_path.y2 = @room.y1
      when :south
        @exit_path = Rectangle.new
        @exit_path.x1 = @room.x_center
        @exit_path.y1 = @room.y2
        @exit_path.x2 = @room.x_center
        @exit_path.y2 = @y2
      when :east
        @exit_path = Rectangle.new
        @exit_path.x1 = @room.x2
        @exit_path.y1 = @room.y_center
        @exit_path.x2 = @x2
        @exit_path.y2 = @room.y_center
      when :west
        @exit_path = Rectangle.new
        @exit_path.x1 = @x1
        @exit_path.y1 = @room.y_center
        @exit_path.x2 = @room.x1
        @exit_path.y2 = @room.y_center
      end
    end

    def update_cells
      for y in @y1..@y2 do
        for x in @x1..@x2 do
          if x.between?(@room.x1, @room.x2) and y.between?(@room.y1, @room.y2)
            @fortress_cells[x][y] = :concrete
          elsif not @exit_path.blank? and x.between?(@exit_path.x1, @exit_path.x2) and y.between?(@exit_path.y1, @exit_path.y2)
            @fortress_cells[x][y] = :concrete
          end
        end
      end
    end
  end 
end