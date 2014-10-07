# This class adds new record to HouddHistory
class DayChanger

  # Add one day to HouddHistory.
  def self.add
    new_day = 1
    new_day = HouddHistory.last.day unless HouddHistory.last.blank?
    history = HouddHistory.new
    history.day = new_day
    history.save

    ProductionQueueUpdater.execute(1)
    MissionMatcher.execute
  end
end