class AddIndexToBrands < ActiveRecord::Migration[5.2]
  def change
    add_index :brands, :brand_name
    add_index :brands, :japanese_brand_name
  end
end
