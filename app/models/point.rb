# This class describes a 2D coordinates in fortress.
class Point
  attr_accessor :x
  attr_accessor :y

  # Initialize this class.
  # @param [Integer] x x-coordinate
  # @param [Integer] y y-coordinate
  def initialize(x, y)
    @x = x
    @y = y
  end

  # Create random point.
  # @param [Integer] size length of a side
  # @return [Object] Point instance.
  def self.random(size)
    x = rand(size * 2) - (size - 1)
    y = rand(size * 2) - (size - 1)
    return Point.new(x, y)
  end

  # Compare parameter point instance and myself.
  # @param [Object] point Point.
  # @return [Boolean]
  def equal?(point)
    return true if @x == point.x and @y == point.y
    return false
  end

  # Add parameter point instance to myself.
  # @note This is a bang method.
  # @param [Object] point Point.
  # @return [Object] point Point.
  def add!(point)
    @x += point.x
    @y += point.y
  end

  # Add parameter point instance to myself.
  # @note This method creates new instance.
  # @param [Object] point Point.
  # @return [Object] point Point.
  def add(point)
    new_point = Marshal.load(Marshal.dump(self))
    new_point.x = @x + point.x
    new_point.y = @y + point.y
    return new_point
  end

  # Subtract parameter point instance from myself.
  # @note This is a bang method.
  # @param [Object] point Point.
  # @return [Object] point Point.
  def sub!(point)
    @x -= point.x
    @y -= point.y
  end

  # Subtract parameter point instance from myself.
  # @note This method creates new instance.
  # @param [Object] point Point.
  # @return [Object] point Point.
  def sub(point)
    new_point = Marshal.load(Marshal.dump(self))
    new_point.x = @x - point.x
    new_point.y = @y - point.y
    return new_point
  end

  # Set all 1 to x and y.
  # @return [Object] point Point.
  # @example
  #  (22, 33) -> (1, 1)
  #  (-22, 33) -> (-1, 1)
  #  (22, -33) -> (1, -1)
  #  (0, 33) -> (0, 1)
  #  (22, 0) -> (1, 0)
  def identity
    new_point = Marshal.load(Marshal.dump(self))
    new_point.x = 0
    new_point.y = 0
    new_point.x = @x / @x.abs if @x != 0
    new_point.y = @y / @y.abs if @y != 0
    return new_point
  end

  # Set 1 to x and 0 to y.
  # @return [Object] point Point.
  # @example
  #  (22, 33) -> (1, 0)
  #  (-22, 33) -> (-1, 0)
  #  (22, -33) -> (1, 0)
  #  (0, 33) -> (0, 0)
  #  (22, 0) -> (1, 0)
  def identity_x
    new_point = identity
    new_point.y = 0
    return new_point
  end

  # Set 0 to x and 1 to y.
  # @return [Object] point Point.
  # @example
  #  (22, 33) -> (0, 1)
  #  (-22, 33) -> (0, 1)
  #  (22, -33) -> (0, -1)
  #  (0, 33) -> (0, 1)
  #  (22, 0) -> (0, 0)
  def identity_y
    new_point = identity
    new_point.x = 0
    return new_point
  end

  # Return all the identities.
  # @return [Array] identities Point.
  # @example
  #  (1, 0), (-1,0), (0, 1), (0, -1)
  def self.identities
    identities = Array.new
    identities.push(Point.new(1, 0))
    identities.push(Point.new(-1, 0))
    identities.push(Point.new(0, 1))
    identities.push(Point.new(0, -1))
    return identities
  end

  # Return Array of identity of subtracted point.
  # @return [Array] identities Point.
  # @example
  #  (22, 33) -> [(1, 0), (0, 1)]
  #  (0, 33) -> [(0, 1)]
  #  (22, 0) -> [(1, 0)]
  #  (0, 0) -> nil
  def sub_identities(point)
    identities = Array.new
    subtracted_point = sub(point)
    identities << subtracted_point.identity_x unless subtracted_point.x == 0
    identities << subtracted_point.identity_y unless subtracted_point.y == 0
    return identities
  end

  # Set 0 or 1 randomly.
  # @return [Object] point Point.
  # @example
  #  (0, 0), (1, 0), (0, 1), (1, 1)
  def identity_random
    new_point = identity
    if new_point.x != 0 and new_point.y != 0
      if rand(2) > 0
        new_point.x = 0
      else
        new_point.y = 0
      end
    end
    return new_point
  end

  # Check whether x and y are 0.
  # @return [Boolean]
  def zero?
    return true if @x == 0 and @y ==0
    return false
  end

  # # Get direction string according to identified value.
  # # @return [String]
  # def trail_str
  #   return 'E' if @x == 1
  #   return 'W' if @x == -1
  #   return 'S' if @y == 1
  #   return 'N' if @y == -1
  #   return ''
  # end
end