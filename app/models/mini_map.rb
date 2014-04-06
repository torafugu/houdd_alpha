# This class describes a mini map.
class MiniMap < ActiveRecord::Base
  belongs_to :houdd_user
  has_many :mini_map_cells
  has_many :mini_map_roads, :foreign_key => 'start_mini_map_id', :class_name => "MiniMapRoad"
  has_many :fortress_cells
  has_many :missions

  validates :houdd_user_id, :presence => true
  validates :name, :presence => true, :uniqueness => true
  validates :size, :numericality => {:only_integer => true, :greater_than_or_equal_to => 3, :less_than_or_equal_to => 10}

  # Return true or false whether mini_map_cells is blank or not.
  # @return [Boolean]
  def status
    return false if mini_map_cells.blank?
    return true
  end

  # Return the description whether mini_map_cells is blank or not.
  # @return [String]
  def status_txt
    return I18n.t('activerecord.attributes.mini_map.cells_filled') if status
    return I18n.t('activerecord.attributes.mini_map.cells_blank') 
  end

  # Return the total number of foods in mini_map_cells.
  # @return [Integer]
  def foods_total
    foods_total = 0
    mini_map_cells.each do |cell|
      foods_total += cell.terrain.food
      foods_total += cell.sp_resource.food unless cell.sp_resource.blank?
      foods_total += cell.construction.food unless cell.construction.blank?
    end
    return foods_total
  end

  # Return the total number of productions in mini_map_cells.
  # @return [Integer]
  def productions_total
    productions_total = 0
    mini_map_cells.each do |cell|
      productions_total += cell.terrain.production
      productions_total += cell.sp_resource.production unless cell.sp_resource.blank?
      productions_total += cell.construction.production unless cell.construction.blank?
    end
    return productions_total
  end

  # Return the total number of moneys in mini_map_cells.
  # @return [Integer]
  def moneys_total
    moneys_total = 0
    mini_map_cells.each do |cell|
      moneys_total += cell.terrain.money
      moneys_total += cell.sp_resource.money unless cell.sp_resource.blank?
      moneys_total += cell.construction.money unless cell.construction.blank?
    end
    return moneys_total
  end

  # Return all the sp_resources in mini_map_cells.
  # @return [Array] array of sp_resource
  def sp_resources_all
    sp_resources = Array.new
    mini_map_cells.each do |cell|
      sp_resources << cell.sp_resource unless cell.sp_resource.blank?
    end
    return sp_resources.uniq
  end

  # Return the description of sp_resource in mini_map_cells.
  # Duplicated sp_resource is displayed only once.
  # @return [String] Comma separated sp_resource.name
  def sp_resources_txt
    sp_resources_txt = ''
    sp_resources = Hash.new
    mini_map_cells.each do |cell|
      if not cell.sp_resource.blank? and sp_resources[cell.sp_resource.symbol].blank?
        sp_resources[cell.sp_resource.symbol] = cell.sp_resource.name
        sp_resources_txt += cell.sp_resource.name
        sp_resources_txt += ','
      end
    end
    sp_resources_txt.chop! if sp_resources_txt.last == ','
    return sp_resources_txt
  end

  # Return true of false whether new root find trial is already execited or not.
  # @return [Boolean]
  def finding_new_road?
    new_root_find_queue = ProductionQueue.find_by_symbol_and_queue_id(:new_root_find.to_s, id)
    return true unless new_root_find_queue.blank?
    return false
  end

  # Return end_mini_map_id if new root find trial is successfull.
  # @return [Integer] end_mini_map.id
  def find_new_road
    return nil if finding_new_road?
    return nil if Params::NEW_ROOT_FIND_PERCENTAGE < rand(Params::PERCENT_DENOMINATOR)

    found_mini_map_ids = mini_map_roads.collect{|r| r.end_mini_map_id}
    found_mini_map_ids << id
    not_found_mini_map_ids = MiniMap.all.collect{|m| m.id} - found_mini_map_ids
    end_mini_map_id = not_found_mini_map_ids[rand(not_found_mini_map_ids.size)]
    
    return end_mini_map_id
  end

  # Return true or false whether fortress_cells is blank or not.
  # @return [Integer]
  def fortress_status
    return false if fortress_cells.blank?
    return true
  end

  # Return the number of squads which are assigned to the fortress on this map.
  # @return [Boolean]
  def fortress_squads_num
    return 0 unless fortress_status
    squads = Array.new
    fortress_cells.each do |cell|
      squads << cell.squad unless cell.squad_id.blank?
    end
    return squads.size
  end

  # Return the number of traps which are installed to the fortress on this map.
  # @return [Boolean]
  def fortress_traps_num
    return 0 unless fortress_status
    traps = Array.new
    fortress_cells.each do |cell|
      traps << cell.squad unless cell.squad_id.blank?
    end
    return traps.size
  end

  # Return true or false whether guard mission for this mini map is existing or not.
  # @return [Boolean]
  def guard_mission_active?
    missions.each do |mission|
      return true if mission.category_symbol == :guard.to_s and mission.status_symbol == :on_going.to_s
    end
    return false
  end

  after_save :create_road_to_hq

  private

  def create_road_to_hq
    if not hq_flg and mini_map_roads.blank?
      mini_map_road = MiniMapRoad.new
      mini_map_road.start_mini_map_id = MiniMap.find_by_houdd_user_id_and_hq_flg(houdd_user_id, true).id
      mini_map_road.end_mini_map_id = id
      mini_map_road.level = 1
      mini_map_road.distance = rand(Params::MAP_DISTANCE_MAX) + 1
      mini_map_road.built_point = 0
      mini_map_road.active_flg = true
      mini_map_road.save
    end
  end
end
