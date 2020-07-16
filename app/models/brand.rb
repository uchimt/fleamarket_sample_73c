class Brand < ApplicationRecord
  belongs_to :product, optional: true
end
