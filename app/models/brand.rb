class Brand < ApplicationRecord
  has_many :products

  def search_brand(search)
    return Brand.all unless search
    Brand.where('japanese_brand_name LIKE(?)', "%#{search}%").or(Brand.where('brand_name LIKE(?)', "%#{search}%"))
  end

end
