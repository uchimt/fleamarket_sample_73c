FactoryBot.define do
  factory :product do
    title            {"イケメンゴリラ"}
    description      { Faker::TvShows::Community.quotes }
    category_id      { 3 }
    size_id          { 3 }
    brand_id         { 5 }
    condition        {"brand_new"}
    postage          {"including_shipping_fee"}
    prefecture_id    { 1 }
    shipping_day_id  { 1 }
    price            { 555 }
    status           { 0 }
    user_id          { 1 }

    after(:build) do |product|
      product.images << build(:image)
    end

  end
end