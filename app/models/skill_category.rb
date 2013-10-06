class SkillCategory < ActiveRecord::Base

  # Return the description of skill type.
  # @return [String]
  def type_sym_txt
    return I18n.t('activerecord.attributes.skill_category.' + type_sym)
  end

  # Return the description of element.
  # @return [String]
  def element_sym_txt
    return I18n.t('activerecord.attributes.element.' + element_sym)
  end

  # Return name.
  # 'name' is not a table column, it is composed from 'type_sym' and 'element'.
  # @return [String]
  def name
    return element_sym_txt + ':' + type_sym_txt
  end
end
