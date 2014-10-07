# This class describes a strategy of mission.
class MissionStrategy < ActiveRecord::Base
  belongs_to :houdd_user

  validates :houdd_user_id, :presence => true
  validates :name, :presence => true
  validates :script, :presence => true

  # This Struct describes a strategy of squad.
  SquadStrategy = Struct.new(:index, :entry_turn)

  # This class describes a strategy of job type.
  class JobTypeStrategy
    attr_accessor :job_type_symbol
    attr_accessor :retreat_hp_rate
    attr_accessor :vpos

    # This class describes a battle strategy of job type.
    class JobTypeBattleStrategy
      attr_accessor :job_type_battle_symbol
      attr_accessor :battle_methods

      # This Struct describes a battle method.
      BattleMethod = Struct.new(:battle_type, :type_symbol, :method, :priority)

      # Initialize this class.
      # @param [String] symbol
      def initialize(symbol)
        @job_type_battle_symbol = symbol
        @battle_methods = Array.new
      end

      # Set battle method as weapon.
      # @param [String] symbol
      # @param [Integer] priority
      def weapon(symbol, priority)
        @battle_methods << BattleMethod.new(:weapon, symbol, nil, priority)
      end

      # Set battle method as skill.
      # @param [String] symbol
      # @param [Integer] priority
      def skill(symbol, priority)
        @battle_methods << BattleMethod.new(:skill, symbol, nil, priority)
      end

      # Return all the battle methods.
      # @return [Array] battle methods.
      def methods
        return @battle_methods
      end

      # Return battle methods selected by priority.
      # @return [Array] battle methods.
      def methods_by_priority(priority)
        sorted_methods = Array.new
        @battle_methods.each do |battle_method|
          sorted_methods << battle_method if battle_method.priority = priority
        end
        return sorted_methods
      end
    end

    # Initialize this class.
    # @param [String] symbol
    def initialize(symbol)
      @job_type_symbol = symbol
      @battle_methods = Hash.new
    end

    # Return the battle object of selected job type.
    # @param [String] symbol
    # @return [Object] battle
    def battle(symbol)
      @battle_methods[symbol] = JobTypeBattleStrategy.new(symbol) if @battle_methods[symbol].nil?
      return @battle_methods[symbol]
    end
  end

  # Execute instance_eval() by MissionStrategy.script.
  def eval_script
    @initialized_flg = true
    @jobtypes = Hash.new
    @squads = Hash.new
    instance_eval(script.gsub("\r\n", ";"))
  end

  # Return the status whether eval_script method has been called or not.
  # @return [Boolean] eval_script status.
  def initialized?
    if @initialized_flg
      return true
    else
      return false
    end
  end

  # Return the job type which was evaluated from script.
  # @param [Integer] symbol
  # @return [Object] job type
  def jobtype(symbol)
    @jobtypes[symbol] = JobTypeStrategy.new(symbol) if @jobtypes[symbol].nil?
    return @jobtypes[symbol]
  end

  # Return the squad which was evaluated from script.
  # @param [Integer] index
  # @return [Object] squad
  def squad(index)
    @squads[index] = SquadStrategy.new(index, 1) if @squads[index].nil?
    return @squads[index]
  end
end
