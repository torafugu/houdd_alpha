# Inventory class of Specie and Job.
class SpecieJobInv < ActiveRecord::Base
  belongs_to :specie
  belongs_to :job
end
