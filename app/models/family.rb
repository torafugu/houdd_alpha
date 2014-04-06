# This class describes a Family.
# The upper class of Specie.
class Family < ActiveRecord::Base
  belongs_to :skill
  has_many :item_infos
end
