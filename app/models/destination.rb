class Destination < ApplicationRecord
  belongs_to :user, optional: true
  validates :destination_first_name,
            :destination_family_name,
            :destination_first_name_kana,
            :destination_family_name_kana,
            :postal_code,
            :prefecture,
            :city,
            :address,
            :building,
            :phone_number,
             presence: true
end
