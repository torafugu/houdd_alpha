# This class describes a dna of mob.
# @note Practically, this class is inventory class of Mob and Gene.
class Dna < ActiveRecord::Base
  belongs_to :mob
  belongs_to :gene
end
