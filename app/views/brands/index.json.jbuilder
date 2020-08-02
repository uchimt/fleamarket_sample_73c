json.array! @brands do |brand|
    json.id brand.id
    json.brand_name brand.brand_name
    json.japanese_brand_name brand.japanese_brand_name
  end