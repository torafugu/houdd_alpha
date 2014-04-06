# This class describes a rectangle.
class Rectangle
  attr_accessor :x1, :y1, :x2, :y2

  # Return center coordinate of x.
  # @return [Integer] x_center x coordinate
  def x_center
    return (@x1 + (@x2 - @x1) / 2).round 
  end

  # Return center coordinate of y.
  # @return [Integer] x_center y coordinate
  def y_center
    return (@y1 + (@y2 - @y1) / 2).round 
  end
end
