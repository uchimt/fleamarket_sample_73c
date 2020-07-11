class Destination < ApplicationRecord
  belongs_to :user, optional: true
  validates :destination_family_name,
            :destination_first_name,
            :destination_family_name_kana,
            :destination_first_name_kana,
            :prefecture,
            :city,
            :address,
             presence: true

  validates :postal_code, presence: true,
                          length: { minimum: 7,maximum: 7 }
end