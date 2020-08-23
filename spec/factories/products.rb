FactoryBot.define do
  factory :product do

    title            {"イケメンゴリラ"}
    description      { Faker::TvShows::Community.quotes }
    condition        {"brand_new"}
    postage          {"including_shipping_fee"}
    prefecture_id    { 1 }
    shipping_day_id  { 1 }
    price            { 555 }
    user
    after(:build) do |product|

      product.category_id = create.(:category_grandchildren).id

      product.images << FactoryBot.build(:image, product: product)
    end
  end

  factory :image do
      src {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.png"), 'image/png') }
  end

end