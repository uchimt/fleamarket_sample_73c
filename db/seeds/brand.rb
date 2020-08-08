require "csv"

CSV.foreach('db/seeds/csv/brand_name.csv', headers: true) do |row|
  Brand.create(
    brand_name: row['brand_name'],
    japanese_brand_name: row['japanese_brand_name']
  )
end