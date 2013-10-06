class Tools

  # Return normal random number. 
  # @return [Float] same range as normal distribution.
  def self.gaussian_rand(mean = 0.0, sd = 1.0)
  	rng = lambda { Kernel.rand }
    theta = 2 * Math::PI * rng.call
    scale = sd * Math.sqrt(-2 * Math.log(1 - rng.call))
    return mean + scale * Math.cos(theta)
  end

  # Return random boolean.
  # @return [Boolean] 50%-true and 50%-false.
  def self.random_boolean
    if rand(2) > 0
      return true
    else
      return false
    end
  end

  def self.sort_by_dex(array)
    sorted_by_dex_array = array.sort{|a,b|
      a.dex <=> b.dex
    }
    avg_dex = sorted_by_dex_array.inject(0.0) {|sum, i| sum += i.dex } / sorted_by_dex_array.size
    var_dex = sorted_by_dex_array.inject(0.0) {|sum ,i| sum += (i.dex - avg_dex)**2 } / sorted_by_dex_array.size
    sd_dex = Math.sqrt(var_dex)
    #p "avg_dex:" + avg_dex.to_s + ",var_dex:" + var_dex.to_s + ",sd_dex:" + sd_dex.to_s
    sorted_by_dex_array.each do |element|
      if var_dex == 0 or sd_dex == 0
        element.ss_dex = 10000
      else
        element.ss_dex = ((element.dex - avg_dex) / sd_dex * 10 + 50).round(2)*100
        if element.ss_dex < 1
          element.ss_dex = 1
        elsif element.ss_dex > 9999
          element.ss_dex = 9999
        end
      end
    end
  end

  def self.filter_in_range(adjust_max, adjust)
    if adjust < 0
      adjust = 0
    elsif adjust_max < adjust
      adjust = adjust_max
    end
    return adjust
  end

  def self.filter_percent(percent)
    if percent < 0.01
      percent = 0.01
    elsif percent > 99.99
      percent = 99.99
    end
    return percent
  end

  def self.calc_distance(point1, point2)
    return Math.sqrt((point1['x'] - point2['x']) ** 2 + (point1['y'] - point2['y']) ** 2)
  end

  def self.calc_distance2(point1, point2)
    return Math.sqrt((point1.x - point2.x) ** 2 + (point1.y - point2.y) ** 2)
  end
end