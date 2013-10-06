class ItemInfo < ActiveRecord::Base
  belongs_to :item_category
  has_many :item_sp_resource_invs

  validates :item_category_id, :presence => true
  validates :size, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10}
  validates :weight_level, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10}
  validates :name, :presence => true, :uniqueness => true
  validates :max_dp, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100000}
  validates :rq_prod_point, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100000}
  validates :research_level, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100}

  # Return the description of required sp_resource of item_info.
  # @return [String] Comma separated sp_resource.name
  def rq_sp_resource_txt
    rq_sp_resource_txt = ''
    item_sp_resource_invs.each do |item_sp_resource_inv|
      rq_sp_resource_txt += item_sp_resource_inv.sp_resource.name
      rq_sp_resource_txt += ','
    end
    rq_sp_resource_txt.chop! if rq_sp_resource_txt.last == ','
    return rq_sp_resource_txt
  end

  # Return all the required sp_resource of item_info.
  # @return [Array] array of sp_resource
  def rq_sp_resources_all
    rq_sp_resources = Array.new
    item_sp_resource_invs.each do |item_sp_resource_inv|
      rq_sp_resources << item_sp_resource_inv.sp_resource
    end
    return rq_sp_resources
  end
end
