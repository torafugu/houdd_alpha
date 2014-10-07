# This class describes a mission.
class Mission < ActiveRecord::Base
  belongs_to :houdd_user
  belongs_to :mini_map
  belongs_to :mission_strategy

  has_many :squads, :through => :mission_queues
  has_many :mission_queues, :dependent => :delete_all

  validates :houdd_user_id, :presence => true
  validates :mini_map_id, :presence => true
  validates :start_houdd_time, :numericality => {:greater_than_or_equal_to => 0}
  validates :end_houdd_time, :numericality => {:greater_than_or_equal_to => 0}
  validate :end_houdd_time_is_earlier_than_start_houdd_time

  # Validate start_houdd_time is earlier than end_houdd_time.
  def end_houdd_time_is_earlier_than_start_houdd_time
    return if start_houdd_time.blank? or end_houdd_time.blank?
    if end_houdd_time < start_houdd_time
      errors.add(:base, I18n.t('activerecord.errors.models.mission.attributes.end_houdd_time_is_earlier_than_start_houdd_time'))
    end
  end

  # Return the name(mini_map.name + category_symbol_txt) of this mission.
  # @return [String]
  def name
    return mini_map.name + '(' + category_symbol_txt + ')'
  end

  # Return the description of category symbol.
  # @return [String]
  def category_symbol_txt
    return I18n.t('activerecord.attributes.mission.' + category_symbol)
  end

  # Return the description of status symbol.
  # @return [String]
  def status_symbol_txt
    return I18n.t('activerecord.attributes.mission.' + status_symbol)
  end

  # Return the squad list which belongs to this mission.
  # @return [String] Comma separated squad.name
  def squads_txt
    squads_txt = ''
    squads.each do |squad|
      if not squad.blank?
        squads_txt += squad.name
        squads_txt += ','
      end
    end
    squads_txt.chop! if squads_txt.last == ','
    return squads_txt
  end

  # Return the mission strategy which belongs to this mission.
  # eval_script is called when the mission strategy is not initialized.
  # @return [Object] mission strategy
  def strategy
    if @loaded_strategy.blank?
      mission_strategy.eval_script
      @loaded_strategy = mission_strategy
    end
    return mission_strategy
  end

  # Return all the completed trials which related with this mission.
  # @return [Array] trials
  def completed_trials
    return Trial.where("(guard_mission_id = ? or intruder_mission_id = ?) and occurred_at is not null", id, id)
  end
end
