# This class describes a mission queue.
class MissionQueue < ActiveRecord::Base
  belongs_to :mission
  belongs_to :squad
end
