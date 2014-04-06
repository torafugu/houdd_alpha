# This class describes a cell of fortress.
class FortressCell < ActiveRecord::Base
  belongs_to :mini_map
  belongs_to :squad, :class_name => 'Squad', :foreign_key => :squad_id
  belongs_to :trap, :class_name => 'Item', :foreign_key => :trap_id
end
