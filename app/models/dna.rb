class Dna < ActiveRecord::Base
  belongs_to :mob
  belongs_to :gene
end
