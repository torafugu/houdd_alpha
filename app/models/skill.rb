# This class describes a skill.
class Skill < ActiveRecord::Base
  # Return the description of skill type.
  # @return [String]
  def type_symbol_txt
    return I18n.t('activerecord.attributes.skill.' + type_symbol)
  end

  # Return the description of element.
  # @return [String]
  def element_symbol_txt
    return I18n.t('activerecord.attributes.element.' + element_symbol)
  end
end
