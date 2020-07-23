require "csv"

CSV.foreach('db/seeds/csv/category_sizes.csv', headers: true) do |row|
  CategorySize.create(
    category_id: row['category_id'],
    products_size_id: row['products_size_id']
  )
end