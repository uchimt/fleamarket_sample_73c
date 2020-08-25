FactoryBot.define do
  factory :product do
    title            {"イケメンゴリラ"}
    description      { Faker::TvShows::Community.quotes }
    category_id      { 4 }
    condition        {"brand_new"}
    postage          {"including_shipping_fee"}
    prefecture_id    { 1 }
    shipping_day_id  { 1 }
    price            { 555 }
    user             { FactoryBot.create(:user)}

    after(:build) do |product|
      product.images << build(:image)
    end

  end
end