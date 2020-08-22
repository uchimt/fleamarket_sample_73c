FactoryBot.define do
  factory :product do
    title          {"イケメンゴリラ"}
    description    { Faker::TvShows::Community.quotes }
    category_id    { "216" }
    condition      {"brand_new"}
    postage        {"including_shipping_fee"}
    prefecture_id  { "1" }
    shipping_id    { "1" }
    price          { "555" }
    user_id        { "1" }

    after(:build) do |product|
      product.images << FactoryBot.build(:image, product: product)
    end
  end

  factory :image do
      src {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/sample.png"), 'image/png') }
  end

end