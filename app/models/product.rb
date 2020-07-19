class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images, dependent: :destroy
  has_one :brand, dependent: :destroy
  belongs_to :category 
  belongs_to :brand
  belongs_to :user
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :brand, allow_destroy: true
  
  validates_associated :images
  validates :images, presence: true
  validates :title, 
            :description, 
            :category_id,
            :condition, 
            :postage, 
            :prefecture_id, 
            :shipping_day_id, 
            :price,
            :user_id, 
             presence: true

  enum condition: { 
    brand_new: 1,               # "新品・未使用"
    look_brand_new: 2,          # "未使用に近い"
    no_noticeable_scratches: 3, #"目立った傷や汚れなし"
    some_scratches: 4,          #"やや傷や汚れあり"
    noticeable_scratches: 5,    #"傷や汚れあり"
    bad_condition: 6            #"全体的に状態が悪い"
  }
  
  enum postage: {
    including_shipping_fee: 1,  # "送料込み（出品者負担）"
    cash_on_delivery: 2         # "着払い（購入者負担）"
  }
  
  enum status: {
    on_display: 0,              # "出品中"
    sold: 1                     # "売却済"
  }
end
