class TrialBattleTurn < ActiveRecord::Base
  belongs_to :trial_battle_set
  has_many :trial_mob_statuses, :dependent => :delete_all

  attr_accessible :log
end
