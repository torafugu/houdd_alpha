# This class describes a construction on mini map.
class Construction < ActiveRecord::Base
  belongs_to :terrain

  validates :symbol, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  validates :food, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :production, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :money, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :rq_prod_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000}
  validates :rq_days, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000}

  # Return the image file name which is created from symbol and prefix.
  # File extension is added on erb of views.
  # @return [String]
  def img_file
    return "const_" + symbol.to_s
  end
end
