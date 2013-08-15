class MiniMapCreator

  # Create random map cells.
  # Terrain, sp_resouce and capital are set to mini_map_cell.
  # @param [integer] mini_map_id id of mini_map class
  def self.random_cell(mini_map_id)
    terrain_plain = Terrain.find_by_symbol(:plain.to_s)
    terrain_woods = Terrain.find_by_symbol(:woods.to_s)
    terrain_mountain = Terrain.find_by_symbol(:mountain.to_s)
    terrain_desert = Terrain.find_by_symbol(:desert.to_s)
    terrain_sea = Terrain.find_by_symbol(:sea.to_s)

    mini_map = MiniMap.find(mini_map_id)
    terrain_symbol_map = Array.new(mini_map.size).map!{Array.new(mini_map.size, 0)}

    MiniMapCell.destroy_all(["mini_map_id = ?", mini_map_id])

    capital_x_roll = rand(mini_map.size)
    capital_y_roll = rand(mini_map.size)

    mini_map.size.times do |y|
      mini_map.size.times do |x|
        mini_map_cell = MiniMapCell.new
        mini_map_cell.mini_map_id = mini_map_id
        mini_map_cell.x = x
        mini_map_cell.y = y

        # 1. Set terrain.
        terrain_sea_freq_rate_zone = terrain_sea.frequency_rate + continuity_mod(terrain_sea, terrain_symbol_map, x, y)
        terrain_desert_freq_rate_zone = terrain_sea_freq_rate_zone + terrain_desert.frequency_rate + continuity_mod(terrain_desert, terrain_symbol_map, x, y)
        terrain_mountain_freq_rate_zone = terrain_desert_freq_rate_zone + terrain_mountain.frequency_rate + continuity_mod(terrain_mountain, terrain_symbol_map, x, y)
        terrain_woods_freq_rate_zone =  terrain_mountain_freq_rate_zone + terrain_woods.frequency_rate + continuity_mod(terrain_woods, terrain_symbol_map, x, y)
        terrain_plain_freq_rate_zone =  Params::PERCENT_DENOMINATOR - terrain_woods_freq_rate_zone

        # p terrain_sea_freq_rate_zone
        # p terrain_desert_freq_rate_zone
        # p terrain_mountain_freq_rate_zone
        # p terrain_woods_freq_rate_zone
        # p terrain_plain_freq_rate_zone

        terrain_roll = rand(Params::PERCENT_DENOMINATOR)
        # p "roll:" + terrain_roll.to_s
        terrain = terrain_plain
        if terrain_roll < terrain_sea_freq_rate_zone
          terrain = terrain_sea
        elsif terrain_roll.between?(terrain_sea_freq_rate_zone, terrain_desert_freq_rate_zone - 1)
          terrain = terrain_desert
        elsif terrain_roll.between?(terrain_desert_freq_rate_zone, terrain_mountain_freq_rate_zone - 1)
          terrain = terrain_mountain
        elsif terrain_roll.between?(terrain_mountain_freq_rate_zone, terrain_woods_freq_rate_zone - 1)
          terrain = terrain_woods
        end

        terrain_symbol_map[x][y] = terrain.symbol.to_sym
        mini_map_cell.terrain_id = terrain.id

        # 2. Set sp resource.
        sp_resource_roll = rand(Params::PERCENT_DENOMINATOR)
        sp_resource_index = 0
        terrain.sp_resources.each do |sp_resource|
          sp_resource_index += sp_resource.frequency_rate
          if sp_resource_roll <= sp_resource_index
            mini_map_cell.sp_resource_id = sp_resource.id
            break
          end
        end

        # 2. Set construction.
        mini_map_cell.construction = nil
        mini_map_cell.built_point = 0
        mini_map_cell.const_active_flg = false

        # 3. Set capital.
        if mini_map_cell.x == capital_x_roll and mini_map_cell.y == capital_y_roll
          mini_map_cell.capital_flg = true
        else
          mini_map_cell.capital_flg = false
        end

        mini_map_cell.save
      end
    end
  end

  private

  def self.continuity_mod(terrain, terrain_symbol_map, x, y)
    continuity_count = 0
    if y > 0
      continuity_count += 1 if  terrain.symbol.to_sym == terrain_symbol_map[x][y - 1]
    end
    if x > 0
      continuity_count += 1 if  terrain.symbol.to_sym == terrain_symbol_map[x - 1][y]
    end
    return continuity_count * terrain.continuity_mod
  end
end