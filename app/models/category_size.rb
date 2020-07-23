class CategorySize < ApplicationRecord
  belongs_to :category
  belongs_to :products_size
end
