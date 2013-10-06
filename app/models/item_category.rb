class ItemCategory < ActiveRecord::Base
  belongs_to :body_part

  # Return the description of item type.
  # @return [String]
  def type_sym_txt
    return I18n.t('activerecord.attributes.research.' + type_sym)
  end
end
