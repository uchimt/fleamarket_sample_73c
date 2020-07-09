class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :family_name,
            :first_name,
            :family_name_kana,
            :first_name_kana,
             presence: true
             
  validates :birth_year, presence: true,
                          length: { minimum: 4,maximum: 4 }
  validates :birth_month, presence: true,
                          length: { maximum: 2 }
  validates :birth_month, presence: true,
                          length: { maximum: 2 }
end
