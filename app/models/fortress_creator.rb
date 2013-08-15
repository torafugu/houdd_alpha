class FortressCreator
  ROOM_BASE_PERCENTAGE = 40
  ROOM_MAX_ADD_PERCENTAGE = 50
  MINIMUM_SIZE = 9
  SIZE_COEFFICIENT = 2
  ENTRANCE_MAX = 4
  UNEVEN_PATH_LENGTH = 4

  def self.random_cell(mini_map_id)
    FortressCell.destroy_all(["mini_map_id = ?", mini_map_id])
    fortress_size = MINIMUM_SIZE + MiniMap.find(mini_map_id).size * SIZE_COEFFICIENT
    fortress_x_cursor = 0
    area_x_num = (fortress_size / MINIMUM_SIZE).truncate
    area_x_size = (fortress_size / area_x_num).truncate
    modified_fortress_size = fortress_size - (fortress_size % area_x_num)
    fortress_cells = Array.new(modified_fortress_size).map!{ Array.new(modified_fortress_size, :blank) }
    areas = Array.new(area_x_num).map!{ Array.new(area_x_num, nil) }

    exit_directions = Params::DIRECTION_SYMBOLS.sample(rand(ENTRANCE_MAX) + 1)
    exit = Struct.new(:direction, :x, :y)
    exit_paths = Array.new
    exit_directions.each do |path|
      case path
      when :north
        exit_paths << exit.new(path, rand(area_x_num), 0)
      when :south
        exit_paths << exit.new(path, rand(area_x_num), area_x_num - 1)
      when :east
        exit_paths << exit.new(path, area_x_num - 1  , rand(area_x_num))
      when :west
        exit_paths << exit.new(path, 0               , rand(area_x_num))
      end
    end

    # create areas
    area_x_num.times do |y|
      area_x_num.times do |x|
        direction = nil
        exit_paths.each do |path|
          if path[:x] == x and path[:y] == y
            direction = path[:direction]
            break
          end
        end
        areas[x][y] = Area.new(x * area_x_size, y * area_x_size, area_x_size, direction, fortress_cells)
      end
    end

    area_path_directions = [:east, :south]
    # create path between areas
    area_x_num.times do |y|
      area_x_num.times do |x|
        fixed_directions = Array.new
        if x < area_x_num - 1 and y < area_x_num - 1
          #fixed_directions = area_path_directions.sample(rand(area_path_directions.size) + 1)
          fixed_directions = area_path_directions.sample(area_path_directions.size)
        elsif x == area_x_num - 1 and y < area_x_num - 1
          # if areas[x - 1][y].is_connected_east?
          #   fixed_directions = [:south].sample(rand([:south].size))
          # else
            fixed_directions = [:south]
          # end
        elsif x < area_x_num - 1 and y == area_x_num - 1
          # if areas[x][y - 1].is_connected_south?
          #   fixed_directions = [:east].sample(rand([:east].size))
          # else
            fixed_directions = [:east]
          # end
        end

        fixed_directions.each do |direction|
          if direction == :east
            p "area(" + x.to_s + "," + y.to_s + "):east path"
            create_room_path(areas[x][y], areas[x + 1][y], :east, fortress_cells)
          elsif direction == :south
            p "area(" + x.to_s + "," + y.to_s + "):south path"
            create_room_path(areas[x][y], areas[x][y + 1], :south, fortress_cells)
          end
          areas[x][y].connected_directions << direction
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

  class Area < Rectangle
    NARROW_BETWEEN_ROOM_AND_AREA_SIZE = 1

    attr_accessor :x1, :x2, :y1, :y2, :room, :connected_directions
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

    def is_connected_east?
      return true if @connected_directions.include?(:east)
      return false
    end

    def is_connected_south?
      return true if @connected_directions.include?(:south)
      return false
    end

    def is_enough_space_room_east?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @x2 - @room.x2
      return false
    end

    def is_enough_space_room_west?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @room.x1 - @x1
      return false
    end

    def is_enough_space_room_north?
      return true if NARROW_BETWEEN_ROOM_AND_AREA_SIZE < @room.y1 - @y1
      return false
    end

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