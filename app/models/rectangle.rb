class Rectangle
  attr_accessor :x1, :y1, :x2, :y2

  def x_center
    return (@x1 + (@x2 - @x1) / 2).round 
  end

  def y_center
    return (@y1 + (@y2 - @y1) / 2).round 
  end
end
