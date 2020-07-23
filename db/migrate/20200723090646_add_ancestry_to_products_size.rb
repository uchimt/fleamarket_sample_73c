class AddAncestryToProductsSize < ActiveRecord::Migration[5.2]
  def change
    add_column :products_sizes, :ancestry, :string
    add_index :products_sizes, :ancestry
  end
end
