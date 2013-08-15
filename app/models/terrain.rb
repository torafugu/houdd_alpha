class Terrain < ActiveRecord::Base
  has_many :sp_resources
  has_many :constructions

  validates :symbol, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  validates :food, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :production, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :money, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}
  validates :frequency_rate, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :continuity_mod, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}

  # Return the image file name which is created from symbol and prefix.
  # File extension is added on erb of views.
  # @return [String]
  def img_file
    return "map_" + symbol.to_s + "_full"
  end

  # Return the white out image file name which is created from img_file and suffix.
  # File extension is added on erb of views.
  # @return [String]
  def img_file_white
    return img_file + "_white"
  end
end
