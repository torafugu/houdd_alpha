# This class keeps all the global common methods.
class Tools
  # Maximum value of sum of squares.
    SS_MAX = 10000

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

  # Return value which was adjusted in range.
  # 0 is returned if value < 0.
  # Adjust_max is returned if adjust_max < value.
  # @param [Integer] adjust_max Maximum value.
  # @param [Integer] value To be checked value.
  # @return [Integer] Adjusted value.
  def self.filter_in_range(adjust_max, value)
    if value < 0
      value = 0
    elsif adjust_max < value
      value = adjust_max
    end
    return value
  end

  # Return value which was adjusted in percentage.
  # 0.01 is returned if value < 0.01.
  # 99.99 is returned if 99.99 < value.
  # @param [Integer] value To be checked value.
  # @return [Integer] Adjusted value.
  def self.filter_in_percentage(value)
    if value < 0.01
      value = 0.01
    elsif value > 99.99
      value = 99.99
    end
    return value
  end

  # Return calculated distance between 2 points.
  # @param [Object] point1 First point
  # @param [Object] point2 Second point
  # @return [Integer] Calculated distance.
  def self.calc_distance(point1, point2)
    return Math.sqrt((point1.x - point2.x) ** 2 + (point1.y - point2.y) ** 2)
  end

  # Return arrays which were sorted by the specified parameter.
  # @note The parameter is normalized by standard deviation before sorting.
  # @return [Array].
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
        element.ss_dex = element.dex
      else
        element.ss_dex = ((element.dex - avg_dex) / sd_dex * 10 + 50).round(2)*100
        if element.ss_dex < 1
          element.ss_dex = 1
        elsif element.ss_dex > Params::SS_MAX - 1
          element.ss_dex = Params::SS_MAX - 1
        end
      end
    end
  end
end